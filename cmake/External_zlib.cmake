# An external project for zlib
set(zlib_source  "${CMAKE_CURRENT_BINARY_DIR}/zlib-src")
set(zlib_build   "${CMAKE_CURRENT_BINARY_DIR}/zlib")
set(zlib_install "${OpenChemistry_INSTALL_PREFIX}")

# If Windows we use CMake, otherwise ./configure
if(WIN32)
  get_filename_component(_self_dir ${CMAKE_CURRENT_LIST_FILE} PATH)

  ExternalProject_Add(zlib
    DOWNLOAD_DIR ${download_dir}
    SOURCE_DIR ${zlib_source}
    BINARY_DIR ${zlib_build}
    INSTALL_DIR ${zlib_install}
    URL ${zlib_url}
    URL_MD5 ${zlib_md5}
    PATCH_COMMAND ${CMAKE_COMMAND} -E remove <SOURCE_DIR>/zconf.h
      COMMAND ${CMAKE_COMMAND} -E copy_if_different
        "${_self_dir}/zlib.CMakeLists.txt"
        "<SOURCE_DIR>/CMakeLists.txt"
      COMMAND ${CMAKE_COMMAND} -E copy_if_different
        "${_self_dir}/zlib.gzguts.h"
        "<SOURCE_DIR>/gzguts.h"
    CMAKE_CACHE_ARGS
      -DCMAKE_CXX_FLAGS:STRING=${pv_tpl_cxx_flags}
      -DCMAKE_C_FLAGS:STRING=${pv_tpl_c_flags}
      -DCMAKE_BUILD_TYPE:STRING=${CMAKE_CFG_INTDIR}
      ${pv_tpl_compiler_args}
      ${zlib_EXTRA_ARGS}
    CMAKE_ARGS
      -DCMAKE_INSTALL_PREFIX:PATH=<INSTALL_DIR>)

  # the zlib library should be named zlib1.lib not zlib.lib
  ExternalProject_Add_Step(zlib RenameLib
    COMMAND ${CMAKE_COMMAND} -E copy "${zlib_install}/lib/zlib.lib"
      "${zlib_install}/lib/zlib1.lib"
    DEPENDEES install)
else()
  ExternalProject_Add(zlib
    DOWNLOAD_DIR ${download_dir}
    SOURCE_DIR ${zlib_source}
    INSTALL_DIR ${zlib_install}
    URL ${zlib_url}
    URL_MD5 ${zlib_md5}
    BUILD_IN_SOURCE 1
    CONFIGURE_COMMAND <SOURCE_DIR>/configure --prefix=<INSTALL_DIR>)
endif()

set(ZLIB_INCLUDE_DIR "${zlib_install}/include" CACHE INTERNAL "")

if(WIN32)
  set(ZLIB_LIBRARY "${zlib_install}/lib/zlib1.${link_library_suffix}"
    CACHE INTERNAL "")
else()
  set(ZLIB_LIBRARY "${zlib_install}/lib/libz.${link_library_suffix}"
    CACHE INTERNAL "")
endif()
