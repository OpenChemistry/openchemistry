get_filename_component(_self_dir ${CMAKE_CURRENT_LIST_FILE} PATH)

configure_file(
  "${_self_dir}/hdf5.CMakeLists.txt.in"
  "${CMAKE_CURRENT_BINARY_DIR}/hdf5.CMakeLists.txt"
  @ONLY
  )

ExternalProject_Add(hdf5
  DOWNLOAD_DIR ${download_dir}
  URL ${hdf5_url}
  URL_MD5 ${hdf5_md5}
  BINARY_DIR "${CMAKE_CURRENT_BINARY_DIR}/hdf5"
  INSTALL_DIR "${OpenChemistry_INSTALL_PREFIX}"
  PATCH_COMMAND ${CMAKE_COMMAND} -E copy_if_different
    "${CMAKE_CURRENT_BINARY_DIR}/hdf5.CMakeLists.txt"
    "<SOURCE_DIR>/CMakeLists.txt"
  CMAKE_ARGS
    -DBUILD_SHARED_LIBS:BOOL=${BUILD_SHARED_LIBS}
    -DCMAKE_INSTALL_PREFIX:PATH=<INSTALL_DIR>
)
