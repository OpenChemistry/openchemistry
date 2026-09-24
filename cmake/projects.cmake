unset(projects)

# Eigen
list(APPEND projects eigen)
set(eigen_version "5.0.1")
set(eigen_url "https://gitlab.com/libeigen/eigen/-/archive/${eigen_version}/eigen-${eigen_version}.tar.gz")
set(eigen_sha256 "e9c326dc8c05cd1e044c71f30f1b2e34a6161a3b6ecf445d56b53ff1669e3dec")

# glew
list(APPEND projects glew)
set(glew_version "2.3.1")
set(glew_url "https://github.com/nigels-com/glew/releases/download/glew-${glew_version}/glew-${glew_version}.tgz")
set(glew_sha256 "b64790f94b926acd7e8f84c5d6000a86cb43967bd1e688b03089079799c9e889")

# gtest
list(APPEND projects gtest)
set(gtest_version "1.18.0")
set(gtest_url "https://github.com/google/googletest/archive/refs/tags/v${gtest_version}.tar.gz")
set(gtest_sha256 "6e3191c1455468b3fc35a417fb565c1c5071aee1b7e7f85e30cf48a98d37d8b5")

# hdf5
list(APPEND projects hdf5)
set(hdf5_version "1_10_10")
set(hdf5_url "https://github.com/HDFGroup/hdf5/archive/hdf5-${hdf5_version}.tar.gz")
set(hdf5_sha256 "563940efec30ec027108bc425f45488ce98d356798bdf743441e574c2d52dd54")

# Open Babel
list(APPEND projects openbabel)
set(openbabel_version "3-2-1")
set(openbabel_url "https://github.com/openbabel/openbabel/archive/openbabel-${openbabel_version}.tar.gz")
#set(openbabel_url "https://github.com/openbabel/openbabel/archive/32cf131444c1555c749b356dab44fb9fe275271f.tar.gz")
set(openbabel_sha256 "e140c25480fe1678d00b9a52462368fa4e7805fba67b12ee496784437f3e239e")

# PCRE
list(APPEND projects pcre)
set(pcre_version "8.45")
set(pcre_url "https://sourceforge.net/projects/pcre/files/pcre/${pcre_version}/pcre-${pcre_version}.tar.gz/download")
set(pcre_sha256 "4e6ce03e0336e8b4a3d6c2b70b1c5e18590a5673a98186da90d4f33c23defc09")

# libxml2
list(APPEND projects libxml2)
set(libxml2_version "2.15.4")
set(libxml2_url "https://gitlab.gnome.org/GNOME/libxml2/-/archive/v${libxml2_version}/libxml2-v${libxml2_version}.tar.gz")
set(libxml2_sha256 "a569ee9c59eabb197a0d5047046d757ee14c86fb2d4a734555b633cb5584ad25")

# Zlib
list(APPEND projects zlib)
set(zlib_version "1.3.2")
set(zlib_url "https://github.com/madler/zlib/archive/v${zlib_version}.tar.gz")
set(zlib_sha256 "17e88863f3600672ab49182f217281b6fc4d3c762bde361935e436a95214d05c")

# KDSoap
list(APPEND projects kdsoap)
set(kdsoap_version "1.10.0")
set(kdsoap_url "https://github.com/KDAB/KDSoap/releases/download/kdsoap-${kdsoap_version}/kdsoap-${kdsoap_version}.tar.gz")
set(kdsoap_sha256 "0c606ecc434466dbadb2829820ca163af60cc7ca226f553b5d4032196737338f")

# spglib
list(APPEND projects spglib)
set(spglib_version "2.7.0")
set(spglib_url "https://github.com/spglib/spglib/archive/v${spglib_version}.tar.gz")
set(spglib_sha256 "b22fc9abae9716c574fbc6d55cfc53ed654a714fccc5657a26ff5d18114bd8bd")

# libarchive
list(APPEND projects libarchive)
set(libarchive_version "3.8.9")
set(libarchive_url "https://github.com/libarchive/libarchive/archive/v${libarchive_version}.tar.gz")
set(libarchive_sha256 "744346f6bca195c8f894f847bb32a16e9bcae6002624a58fadc81e80f595b3cb")

# libmsym
list(APPEND projects libmsym)
IF (WIN32)
  set(libmsym_url "https://github.com/mcodev31/libmsym/archive/0c47befe4a1cd05cbba1aa561b914be926e5ced7.tar.gz")
  set(libmsym_sha256 "7a8ef0eaaa3319fbf2bd4c829395706b9b28e76adad65385851c491f81cf196f")
ELSE()
  set(libmsym_url "https://github.com/mcodev31/libmsym/archive/85e47232376a8e735c2a7b5283f40b59b3953db1.tar.gz")
  set(libmsym_sha256 "456e2c1e0c78e212115d4d332f557f108b6d41b730d5fd6639c2452df31b7096")
ENDIF()

# sentry-native (crash reporting, Windows diagnostic builds only)
# NOTE: this must be the release asset, not the /archive/ tarball - only the
# release asset vendors crashpad.
list(APPEND projects sentry)
set(sentry_version "0.16.3")
set(sentry_url "https://github.com/getsentry/sentry-native/releases/download/${sentry_version}/sentry-native.zip")
set(sentry_sha256 "21380c182dde677794a7b6c57e8d6e03d79ec5a03eec67514ffa7522f7e161b5")
