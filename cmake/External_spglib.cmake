# An external project for spglib
set(spglib_source  "${CMAKE_CURRENT_BINARY_DIR}/spglib-src")
set(spglib_install "${OpenChemistry_INSTALL_PREFIX}")

get_filename_component(_self_dir ${CMAKE_CURRENT_LIST_FILE} PATH)

ExternalProject_Add(spglib
  DOWNLOAD_DIR ${download_dir}
  SOURCE_DIR "${spglib_source}"
  INSTALL_DIR "${spglib_install}"
  URL ${spglib_url}
  URL_MD5 ${spglib_md5}
  BUILD_IN_SOURCE 1
  CMAKE_ARGS
    ${OpenChemistry_DEFAULT_ARGS}
    -DCMAKE_INSTALL_PREFIX:PATH=<INSTALL_DIR>
    -DSPGLIB_WITH_TESTS=OFF
)
