# Generates (or verifies) the pre-downloaded `type: file` sources in the
# Flatpak manifest from the versions declared in projects.cmake.
#
# Flatpak builds have no network access, so every tarball the superbuild would
# normally fetch on the fly has to be listed in the manifest ahead of time and
# downloaded into `Downloads` (see -DDOWNLOAD_TO_SOURCE_DIR=ON). That list used
# to be maintained by hand, so bumping a version in projects.cmake silently
# broke the Flatpak CI. This script keeps the two in sync.
#
# Generate (rewrites the manifest in place):
#   cmake -DMANIFEST=avogadroapp/flatpak/org.openchemistry.Avogadro2.yaml \
#         -P cmake/flatpak_sources.cmake
#
# Check only (non-zero exit if the manifest is stale, used by CI):
#   cmake -DMANIFEST=avogadroapp/flatpak/org.openchemistry.Avogadro2.yaml \
#         -DCHECK=ON -P cmake/flatpak_sources.cmake

get_filename_component(_self_dir ${CMAKE_CURRENT_LIST_FILE} PATH)

# projects.cmake picks a different libmsym commit on Windows. Flatpaks are
# Linux-only, so force the non-Windows branch -- otherwise regenerating this
# from a Windows checkout would quietly emit the wrong sources.
set(WIN32 FALSE)
include("${_self_dir}/projects.cmake")

if(NOT DEFINED MANIFEST)
  message(FATAL_ERROR "Set -DMANIFEST=<path to the Flatpak manifest>")
endif()

# Which of the projects.cmake entries the Flatpak actually builds. This tracks
# the config-opts in the manifest: Open Babel, zlib and libxml2 come from the
# system, MoleQueue/HDF5/testing are off, and JKQtPlotter uses a git source.
# Versions come from projects.cmake -- only edit this list if the manifest
# starts or stops building one of these.
set(_flatpak_projects glew eigen spglib libarchive libmsym)

set(_begin "      # BEGIN GENERATED SOURCES")
set(_end "      # END GENERATED SOURCES")

set(_generated "${_begin} -- edit projects.cmake, then run cmake/flatpak_sources.cmake\n")
foreach(_proj ${_flatpak_projects})
  if(NOT DEFINED ${_proj}_url OR NOT DEFINED ${_proj}_sha256)
    message(FATAL_ERROR "projects.cmake defines no url/sha256 for '${_proj}'")
  endif()
  string(APPEND _generated "      # ${_proj}\n")
  string(APPEND _generated "      - type: file\n")
  string(APPEND _generated "        url: ${${_proj}_url}\n")
  string(APPEND _generated "        sha256: ${${_proj}_sha256}\n")
  string(APPEND _generated "        dest: Downloads\n")
endforeach()
string(APPEND _generated "${_end}")

if(NOT EXISTS "${MANIFEST}")
  message(FATAL_ERROR "No such manifest: ${MANIFEST}")
endif()
file(READ "${MANIFEST}" _manifest)

# Replace everything between the markers, leaving the rest of the file (and its
# comments) untouched.
string(REGEX REPLACE "\n" "\\\\n" _begin_re "${_begin}")
if(NOT _manifest MATCHES "${_begin}[^\n]*\n.*${_end}")
  message(FATAL_ERROR
    "Could not find the generated block in ${MANIFEST}.\n"
    "It must contain these two marker lines:\n${_begin}\n${_end}")
endif()
string(REGEX REPLACE "${_begin}[^\n]*\n(.*\n)?${_end}" "${_generated}"
  _updated "${_manifest}")

if(CHECK)
  if(NOT _updated STREQUAL _manifest)
    message(FATAL_ERROR
      "${MANIFEST} is out of sync with cmake/projects.cmake.\n"
      "The Flatpak build would fail because it pre-downloads the wrong "
      "tarballs. Regenerate it with:\n"
      "  cmake -DMANIFEST=${MANIFEST} -P cmake/flatpak_sources.cmake\n"
      "and commit the result (the manifest lives in the avogadroapp repo).")
  endif()
  message(STATUS "${MANIFEST} is in sync with projects.cmake")
else()
  file(WRITE "${MANIFEST}" "${_updated}")
  message(STATUS "Wrote Flatpak sources for: ${_flatpak_projects}")
endif()
