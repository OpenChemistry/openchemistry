# Build boost via its bootstrap script. The build tree cannot contain a space.
# This boost b2 build system yields errors with spaces in the name of the
# build dir.
#
if("${CMAKE_CURRENT_BINARY_DIR}" MATCHES " ")
  message(FATAL_ERROR "cannot use boost bootstrap with a space in the name of the build dir")
endif()

if(NOT DEFINED use_bat)
  if(WIN32)
    set(use_bat 1)
  else()
    set(use_bat 0)
  endif()
endif()

if(use_bat)
  set(boost_cmds
    CONFIGURE_COMMAND bootstrap.bat
    BUILD_COMMAND b2
    INSTALL_COMMAND b2 --prefix=<INSTALL_DIR> install
  )
  set(boost_include_suffix "include/boost-1_48")
else()
  set(boost_cmds
    CONFIGURE_COMMAND ./bootstrap.sh --prefix=<INSTALL_DIR>
    BUILD_COMMAND ./b2
    INSTALL_COMMAND ./b2 install
  )
  set(boost_include_suffix "include")
endif()

ExternalProject_Add(boost
  DOWNLOAD_DIR ${download_dir}
  URL ${boost_url}
  URL_MD5 ${boost_md5}
  ${boost_cmds}
  BUILD_IN_SOURCE 1
)

ExternalProject_Get_Property(boost install_dir)
set(Boost_INCLUDE_DIR "${install_dir}/${boost_include_suffix}")

message("Boost_INCLUDE_DIR='${Boost_INCLUDE_DIR}'")
