# An external project for libarchive
set(libarchive_source  "${CMAKE_CURRENT_BINARY_DIR}/libarchive-src")
set(libarchive_install "${OpenChemistry_INSTALL_PREFIX}")

get_filename_component(_self_dir ${CMAKE_CURRENT_LIST_FILE} PATH)

ExternalProject_Add(libarchive
  DOWNLOAD_DIR ${download_dir}
  SOURCE_DIR "${libarchive_source}"
  INSTALL_DIR "${libarchive_install}"
  URL ${libarchive_url}
  URL_SHA256 ${libarchive_sha256}
  BUILD_IN_SOURCE 1
  CMAKE_ARGS
    -DCMAKE_INSTALL_PREFIX:PATH=<INSTALL_DIR>
)
