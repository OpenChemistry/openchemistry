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

if(CMAKE_SIZEOF_VOID_P EQUAL 8)
  set(am 64)
else()
  set(am 32)
endif()

set(boost_with_args
  --with-date_time
  --with-filesystem
  --with-iostreams
  --with-program_options
  --with-system
  --with-thread
  --layout=system
)

if(use_bat)
  if(MSVC90)
    set(_toolset "msvc-9.0")
  elseif(MSVC10)
    set(_toolset "msvc-10.0")
  elseif(MSVC11)
    set(_toolset "msvc-11.0")
  endif()

  string(TOLOWER ${CMAKE_BUILD_TYPE} _variant)
  list(APPEND boost_with_args "variant=${_variant}" "toolset=${_toolset}")

  set(boost_cmds
    CONFIGURE_COMMAND bootstrap.bat
    BUILD_COMMAND b2 address-model=${am} ${boost_with_args}
    INSTALL_COMMAND b2 address-model=${am} ${boost_with_args}
      --prefix=<INSTALL_DIR> install
  )
else()
  set(boost_cmds
    CONFIGURE_COMMAND ./bootstrap.sh --prefix=<INSTALL_DIR>
    BUILD_COMMAND ./b2 address-model=${am} ${boost_with_args}
    INSTALL_COMMAND ./b2 address-model=${am} ${boost_with_args}
      install
  )
endif()

ExternalProject_Add(boost
  DOWNLOAD_DIR ${download_dir}
  URL ${boost_url}
  URL_MD5 ${boost_md5}
  SOURCE_DIR "${CMAKE_CURRENT_BINARY_DIR}/boost"
  INSTALL_DIR "${OpenChemistry_INSTALL_PREFIX}"
  ${boost_cmds}
  BUILD_IN_SOURCE 1
)

ExternalProject_Get_Property(boost install_dir)
set(BOOST_ROOT "${install_dir}" CACHE INTERNAL "")

list(APPEND OpenChemistry_THIRDPARTYLIBS_ARGS
# Add Boost properties so correct version of Boost is found.
  "-DBOOST_ROOT:PATH=${BOOST_ROOT}"
  "-DBoost_INCLUDE_DIR:PATH=${BOOST_ROOT}/include"
  "-DBOOST_LIBRARYDIR:PATH=${BOOST_ROOT}/lib"
  "-DBoost_NO_SYSTEM_PATHS:BOOL=ON")
