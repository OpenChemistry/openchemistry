"""Check desktop helper availability and profile isolation without downloads.

Run with Python 3 and CMake/Ninja on PATH. Set Qt6_DIR if Qt is not discoverable.
"""

from pathlib import Path
import subprocess
import tempfile
import unittest


SOURCE = Path(__file__).resolve().parents[1]


class SuperbuildHelpersTest(unittest.TestCase):
    def configure(self, **options):
        directory = tempfile.TemporaryDirectory(prefix="openchemistry-helpers-")
        self.addCleanup(directory.cleanup)
        build = Path(directory.name)
        result = subprocess.run(
            ["cmake", "-S", str(SOURCE), "-B", str(build), "-G", "Ninja",
             "-DUSE_PLOTTER=OFF",
             *[f"-D{key}={value}" for key, value in options.items()]],
            capture_output=True, text=True,
        )
        self.assertEqual(result.returncode, 0, result.stdout + result.stderr)
        targets = subprocess.check_output(
            ["ninja", "-C", str(build), "-t", "targets", "all"], text=True
        )
        return build, {line.split(": ", 1)[0] for line in targets.splitlines()}

    def test_desktop_helpers_and_optional_yaehmop(self):
        _, targets = self.configure()
        self.assertIn("openbabel", targets)
        self.assertNotIn("yaehmop", targets)
        build, targets = self.configure(USE_YAEHMOP="ON")
        self.assertIn("openbabel", targets)
        self.assertIn("yaehmop", targets)
        commands = (build / "build.ninja").read_text()
        self.assertIn(str(SOURCE / "thirdparty/yaehmop/tightbind"), commands)

    def test_system_helpers_are_not_built(self):
        for setting in ("USE_SYSTEM_YAEHMOP", "USE_SYSTEM_YAEMOP"):
            with self.subTest(setting=setting):
                _, targets = self.configure(
                    USE_SYSTEM_OPENBABEL="ON", USE_YAEHMOP="ON",
                    **{setting: "ON"},
                )
                for name in ("openbabel", "yaehmop", "zlib", "libxml2"):
                    self.assertNotIn(name, targets)

    def test_bundled_openbabel_dependencies(self):
        _, targets = self.configure(USE_SYSTEM_ZLIB="OFF", USE_SYSTEM_LIBXML2="OFF")
        for name in ("openbabel", "zlib", "libxml2"):
            self.assertIn(name, targets)

    def test_python_bindings_configure_with_bundled_pybind11(self):
        _, targets = self.configure(USE_PYTHON="ON")
        self.assertIn("pybind11", targets)

    def test_bundled_libxml2_with_system_zlib(self):
        _, targets = self.configure(USE_SYSTEM_ZLIB="ON", USE_SYSTEM_LIBXML2="OFF")
        self.assertIn("libxml2", targets)
        self.assertIn("openbabel", targets)
        self.assertNotIn("zlib", targets)

    def test_subprocess_free_profiles_exclude_helpers(self):
        for web in ("OFF", "ON"):
            with self.subTest(web=web):
                _, targets = self.configure(
                    ENABLE_SUBPROCESS="OFF", AVOGADRO_WEB_EDITOR=web,
                    USE_YAEHMOP="ON",
                )
                for name in ("openbabel", "yaehmop", "zlib", "libxml2"):
                    self.assertNotIn(name, targets)


if __name__ == "__main__":
    unittest.main()
