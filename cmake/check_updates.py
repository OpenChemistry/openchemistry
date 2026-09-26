#!/usr/bin/env python3
"""Check the versions pinned in projects.cmake against upstream releases.

Two modes, so that the file editing stays separate from the git/gh plumbing in
.github/workflows/update-dependencies.yml:

  --list             report available updates as JSON on stdout
  --apply PROJ VER   rewrite projects.cmake for one project, downloading the
                     new tarball to compute its sha256

Tracking metadata (which repo, how tags map to version strings, how large a
jump may be proposed) lives in dependency-updates.json next to this file.

Only the standard library is used, so this runs on a bare GitHub runner.
"""

import argparse
import hashlib
import json
import os
import re
import sys
import urllib.error
import urllib.parse
import urllib.request

HERE = os.path.dirname(os.path.abspath(__file__))
PROJECTS_CMAKE = os.path.join(HERE, "projects.cmake")
CONFIG = os.path.join(HERE, "dependency-updates.json")

USER_AGENT = "openchemistry-dependency-check"


def load_config():
    with open(CONFIG) as f:
        return json.load(f)


# --- projects.cmake parsing -------------------------------------------------

def parse_projects_cmake(text):
    """Return {project: {"version": str, "url": str, "sha256": str}}.

    Only entries that actually declare a version are returned; libmsym pins a
    commit and has no _version, so it is skipped by construction.
    """
    found = {}
    for key in ("version", "url", "sha256"):
        for m in re.finditer(
            r'^\s*set\((\w+)_%s\s+"([^"]*)"\)' % key, text, re.MULTILINE
        ):
            found.setdefault(m.group(1), {})[key] = m.group(2)
    return {p: v for p, v in found.items() if "version" in v}


def resolve_url(project, entry, version):
    """Substitute ${proj_version} in the url, so the pin drives the URL."""
    return entry["url"].replace("${%s_version}" % project, version)


# --- version handling ------------------------------------------------------

def version_key(version):
    """Split a version into ints for comparison. Handles . - and _ separators."""
    return tuple(int(p) for p in re.split(r"[.\-_]", version) if p != "")


def allowed_bump(current, candidate, track):
    """Is `candidate` a newer version we're willing to propose automatically?"""
    cur, cand = version_key(current), version_key(candidate)
    if cand <= cur:
        return False
    if track == "major":
        return True
    if track == "minor":
        # Same major only. Eigen publishes 5.0.1 while we pin 3.4.0; jumping
        # that automatically would be nonsense.
        return cand[:1] == cur[:1]
    if track == "patch":
        return cand[:-1] == cur[:-1] if len(cand) == len(cur) else False
    raise ValueError("unknown track %r" % track)


# --- upstream queries ------------------------------------------------------

def http_json(url):
    req = urllib.request.Request(url, headers={"User-Agent": USER_AGENT})
    token = os.environ.get("GITHUB_TOKEN")
    if token and "api.github.com" in url:
        req.add_header("Authorization", "Bearer " + token)
    with urllib.request.urlopen(req, timeout=60) as r:
        return json.load(r)


def fetch_tags(cfg):
    """Return the upstream tag names for one configured project."""
    if cfg["host"] == "github":
        url = "https://api.github.com/repos/%s/tags?per_page=100" % cfg["repo"]
        return [t["name"] for t in http_json(url)]
    if cfg["host"] == "gitlab":
        url = "%s/projects/%s/repository/tags?per_page=100" % (
            cfg["api"].rstrip("/"),
            urllib.parse.quote(cfg["repo"], safe=""),
        )
        return [t["name"] for t in http_json(url)]
    raise ValueError("unknown host %r" % cfg["host"])


def parse_versions(cfg, tags):
    """Every tag that parses as a version, ascending.

    Tag order from the APIs is not reliable -- HDF5 returns branch-ish tags
    first, Eigen mixes in 'nightly' -- so filter, then sort numerically.
    """
    prefix, pattern = cfg["prefix"], re.compile(cfg["pattern"])
    versions = []
    for tag in tags:
        if prefix and not tag.startswith(prefix):
            continue
        version = tag[len(prefix):]
        if pattern.match(version):
            versions.append(version)
    return sorted(set(versions), key=version_key)


# --- modes -----------------------------------------------------------------

def do_list(config, only=None):
    with open(PROJECTS_CMAKE) as f:
        pinned = parse_projects_cmake(f.read())

    tracked = config["projects"]
    untracked = config.get("untracked", {})

    unknown = sorted(set(pinned) - set(tracked) - set(untracked))
    for project in unknown:
        print(
            "warning: %s is pinned in projects.cmake but not listed in "
            "dependency-updates.json; add it under 'projects' or 'untracked'"
            % project,
            file=sys.stderr,
        )

    updates = []
    for project, cfg in sorted(tracked.items()):
        if only and project != only:
            continue
        if project not in pinned:
            print("warning: %s is configured but not in projects.cmake"
                  % project, file=sys.stderr)
            continue
        current = pinned[project]["version"]
        try:
            versions = parse_versions(cfg, fetch_tags(cfg))
        except (urllib.error.URLError, urllib.error.HTTPError, ValueError) as e:
            print("warning: could not check %s: %s" % (project, e),
                  file=sys.stderr)
            continue
        if not versions:
            print("warning: no parseable tags for %s" % project,
                  file=sys.stderr)
            continue

        track = cfg.get("track", "minor")
        # Narrow to what `track` permits *before* taking the newest, so that a
        # big jump upstream can't mask a smaller one we would accept (a new
        # kdsoap 1.x must not be hidden behind 2.3.0).
        candidates = [v for v in versions if allowed_bump(current, v, track)]
        newest_overall = versions[-1]

        if candidates:
            newest = candidates[-1]
            updates.append({
                "project": project,
                "current": current,
                "latest": newest,
                "newest_upstream": newest_overall,
                "track": track,
                "url": resolve_url(project, pinned[project], newest),
                "flatpak": project in config.get("flatpak_projects", []),
            })
        elif version_key(newest_overall) > version_key(current):
            print("held back: %s %s -> %s exceeds track=%s, needs a human"
                  % (project, current, newest_overall, track), file=sys.stderr)
        else:
            print("up to date: %s %s" % (project, current), file=sys.stderr)

    json.dump(updates, sys.stdout, indent=2)
    sys.stdout.write("\n")
    return 0


def sha256_of(url):
    req = urllib.request.Request(url, headers={"User-Agent": USER_AGENT})
    digest = hashlib.sha256()
    with urllib.request.urlopen(req, timeout=600) as r:
        for chunk in iter(lambda: r.read(1 << 20), b""):
            digest.update(chunk)
    return digest.hexdigest()


def do_apply(config, project, version):
    with open(PROJECTS_CMAKE) as f:
        text = f.read()
    pinned = parse_projects_cmake(text)
    if project not in pinned:
        print("error: %s is not pinned in projects.cmake" % project,
              file=sys.stderr)
        return 1

    url = resolve_url(project, pinned[project], version)
    print("fetching %s" % url, file=sys.stderr)
    try:
        sha = sha256_of(url)
    except (urllib.error.URLError, urllib.error.HTTPError) as e:
        # A 404 here usually means the tag exists but the archive URL pattern
        # changed upstream, which needs a human.
        print("error: could not download %s: %s" % (url, e), file=sys.stderr)
        return 1
    print("sha256 %s" % sha, file=sys.stderr)

    text, n = re.subn(
        r'(set\(%s_version\s+")[^"]*(")' % re.escape(project),
        r"\g<1>%s\g<2>" % version, text)
    if n != 1:
        print("error: expected 1 version line for %s, replaced %d"
              % (project, n), file=sys.stderr)
        return 1
    text, n = re.subn(
        r'(set\(%s_sha256\s+")[^"]*(")' % re.escape(project),
        r"\g<1>%s\g<2>" % sha, text)
    if n != 1:
        print("error: expected 1 sha256 line for %s, replaced %d"
              % (project, n), file=sys.stderr)
        return 1

    with open(PROJECTS_CMAKE, "w") as f:
        f.write(text)
    print("updated projects.cmake: %s -> %s" % (project, version),
          file=sys.stderr)
    return 0


def main():
    p = argparse.ArgumentParser(description=__doc__,
                                formatter_class=argparse.RawDescriptionHelpFormatter)
    g = p.add_mutually_exclusive_group(required=True)
    g.add_argument("--list", action="store_true",
                   help="report available updates as JSON")
    g.add_argument("--apply", nargs=2, metavar=("PROJECT", "VERSION"),
                   help="pin PROJECT to VERSION and refresh its sha256")
    p.add_argument("--project", help="with --list, check only this project")
    args = p.parse_args()

    config = load_config()
    if args.list:
        return do_list(config, only=args.project)
    return do_apply(config, args.apply[0], args.apply[1])


if __name__ == "__main__":
    sys.exit(main())
