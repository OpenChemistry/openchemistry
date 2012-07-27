# An external project for GLEW, The OpenGL Extension Wrangler Library
# http://glew.sourceforge.net/
set(glew_source  "${CMAKE_CURRENT_BINARY_DIR}/glew")
set(glew_install "${OpenChemistry_INSTALL_PREFIX}")

get_filename_component(_self_dir ${CMAKE_CURRENT_LIST_FILE} PATH)

configure_file(
  "${_self_dir}/glew.CMakeLists.txt.in"
  "${CMAKE_CURRENT_BINARY_DIR}/glew.CMakeLists.txt"
  @ONLY
  )

ExternalProject_Add(glew
  DOWNLOAD_DIR ${download_dir}
  SOURCE_DIR ${glew_source}
  INSTALL_DIR ${glew_install}
  URL ${glew_url}
  URL_MD5 ${glew_md5}
  PATCH_COMMAND ${CMAKE_COMMAND} -E copy_if_different
    "${CMAKE_CURRENT_BINARY_DIR}/glew.CMakeLists.txt"
    "<SOURCE_DIR>/CMakeLists.txt"
  CMAKE_ARGS
    -DCMAKE_INSTALL_PREFIX:PATH=<INSTALL_DIR>
  )
