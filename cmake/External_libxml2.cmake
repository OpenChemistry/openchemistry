# An external project for libxml2
set(libxml2_source  "${CMAKE_CURRENT_BINARY_DIR}/libxml2")
set(libxml2_install "${OpenChemistry_INSTALL_PREFIX}")

# If Windows we use configure.js and nmake, otherwise ./configure and make
if(WIN32)
  get_filename_component(_self_dir ${CMAKE_CURRENT_LIST_FILE} PATH)

  file(TO_NATIVE_PATH ${libxml2_install} libxml2_install_win)
  file(TO_NATIVE_PATH ${ZLIB_INCLUDE_DIR} ZLIB_INCLUDE_DIR_win)
  file(WRITE ${CMAKE_CURRENT_BINARY_DIR}/libxml2_config.cmake "
execute_process(
  COMMAND cscript configure.js compiler=msvc prefix=${libxml2_install_win} iconv=no zlib=yes include=\"${ZLIB_INCLUDE_DIR_win}\" lib=\"${libxml2_install_win}/lib\"
  WORKING_DIRECTORY \"${libxml2_source}/win32\"
  )")
  file(WRITE ${CMAKE_CURRENT_BINARY_DIR}/libxml2_build.cmake "
execute_process(
  COMMAND nmake /f Makefile.msvc
  WORKING_DIRECTORY \"${libxml2_source}/win32\"
  )")
  file(WRITE ${CMAKE_CURRENT_BINARY_DIR}/libxml2_install.cmake "
execute_process(
  COMMAND nmake /f Makefile.msvc install
  WORKING_DIRECTORY \"${libxml2_source}/win32\"
  )")

#  set(libxml2_patch_command PATCH_COMMAND ${CMAKE_COMMAND} -E copy_if_different
#    ${_self_dir}/libxml2_Makefile.msvc ${libxml2_source}/win32/Makefile.msvc)
  set(libxml2_config_command CONFIGURE_COMMAND ${CMAKE_COMMAND} -P
    ${CMAKE_CURRENT_BINARY_DIR}/libxml2_config.cmake)
  set(libxml2_build_command BUILD_COMMAND ${CMAKE_COMMAND} -P
    ${CMAKE_CURRENT_BINARY_DIR}/libxml2_build.cmake)
  set(libxml2_install_command INSTALL_COMMAND ${CMAKE_COMMAND} -P
    ${CMAKE_CURRENT_BINARY_DIR}/libxml2_install.cmake)
else()
  set(libxml2_patch_command "")
  set(libxml2_config_command CONFIGURE_COMMAND ./configure --prefix=${libxml2_install} --without-python )
  set(libxml2_build_command "")
  set(libxml2_install_command "")
endif()

ExternalProject_Add(libxml2
  DOWNLOAD_DIR ${download_dir}
  SOURCE_DIR ${libxml2_source}
  INSTALL_DIR ${libxml2_install}
  URL ${libxml2_url}
  URL_MD5 ${libxml2_md5}
  BUILD_IN_SOURCE 1
  ${libxml2_patch_command}
  ${libxml2_config_command}
  ${libxml2_build_command}
  ${libxml2_install_command}
  DEPENDS zlib)

set(LIBXML2_INCLUDE_DIR "${libxml2_install}/include" CACHE INTERNAL "")
set(LIBXML2_LIBRARIES "${libxml2_install}/lib/libxml2.${link_library_suffix}"
  CACHE INTERNAL "")
