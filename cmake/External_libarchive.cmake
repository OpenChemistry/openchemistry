# An external project for libarchive
set(libarchive_source  "${CMAKE_CURRENT_BINARY_DIR}/libarchive-src")
set(libarchive_install "${OpenChemistry_INSTALL_PREFIX}")

get_filename_component(_self_dir ${CMAKE_CURRENT_LIST_FILE} PATH)

set(_libarchive_platform_args)
# Note: LZMA (.xz) used to be disabled on macOS because liblzma was missing on
# the 14.x runners. It is available again, and the Mac workflow now installs it
# explicitly, so xz is built everywhere. macdeployqt rewrites and bundles the
# result into Contents/Frameworks alongside libzstd and liblz4, which was
# verified against a shipped bundle. If a platform genuinely lacks liblzma the
# build still succeeds, libarchive simply reports xz as unsupported and
# Avogadro refuses .xz files with a clear message rather than misreading them.

ExternalProject_Add(libarchive
  DOWNLOAD_DIR ${download_dir}
  SOURCE_DIR "${libarchive_source}"
  INSTALL_DIR "${libarchive_install}"
  URL ${libarchive_url}
  URL_HASH SHA256=${libarchive_sha256}
  BUILD_IN_SOURCE 1
  CMAKE_ARGS
    -DCMAKE_POLICY_VERSION_MINIMUM=3.5
    -DCMAKE_INSTALL_PREFIX:PATH=<INSTALL_DIR>
    ${_libarchive_platform_args}
)
