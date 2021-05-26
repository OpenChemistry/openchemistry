# An external project for yaehmop

unset(_deps)
add_optional_deps(_deps "vtk")

if(NOT USE_SYSTEM_YAEHMOP)
  if(BUILD_YAEHMOP)
    # Yaehmop depends on f2c or gfortran, with an optional dependency on
    # blas and lapack. This may be hard to do on windows.
    set(_source "${CMAKE_CURRENT_SOURCE_DIR}/yaehmop/tightbind")
    set(_build "${CMAKE_CURRENT_BINARY_DIR}/yaehmop")
    set(_install "${OpenChemistry_INSTALL_PREFIX}")

    ExternalProject_Add(yaehmop
      SOURCE_DIR ${_source}
      BINARY_DIR ${_build}
      INSTALL_DIR ${_install}
      CMAKE_CACHE_ARGS
        ${OpenChemistry_DEFAULT_ARGS}
    DEPENDS
      ${_deps}
  )  else()
    # Need to use ExternalProject_Add
    set(YAEHMOP_NAME "yaehmop")
    if(WIN32)
      string(APPEND YAEHMOP_NAME ".exe")
    endif(WIN32)

    ExternalProject_Add(yaehmop
      DOWNLOAD_DIR "${download_dir}"
      DOWNLOAD_NAME "${YAEHMOP_NAME}.tgz"
      URL ${yaehmop_binary_url}
      URL_MD5 ${yaehmop_binary_md5}
      CONFIGURE_COMMAND "" # Do not configure
      BUILD_COMMAND "" # Do not build
      INSTALL_COMMAND "${CMAKE_COMMAND}" "-E" "copy"
        "<SOURCE_DIR>/${YAEHMOP_NAME}" "${OpenChemistry_INSTALL_PREFIX}/bin"
    )
  endif()
endif()
