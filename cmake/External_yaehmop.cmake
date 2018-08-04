# An external project for yaehmop

unset(_deps)
add_optional_deps(_deps "vtk")

if(NOT USE_SYSTEM_YAEHMOP)
  if(BUILD_YAEHMOP)
    # This does not work currently
    # Yaehmop depends on f2c or gfortran, with an optional dependency on
    # blas and lapack. This may be hard to do on windows.
    message(FATAL_ERROR "Yaehmop cannot currently be built here")
  else()
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
