set(_build "${CMAKE_CURRENT_BINARY_DIR}/chemkit")

unset(_deps)
if(NOT USE_SYSTEM_BOOST)
  list(APPEND _deps boost)
endif()
if(NOT USE_SYSTEM_EIGEN)
  list(APPEND _deps eigen)
endif()

ExternalProject_Add(chemkit
  DOWNLOAD_DIR ${download_dir}
  BINARY_DIR ${_build}
  URL ${chemkit_url}
  URL_MD5 ${chemkit_md5}
  CMAKE_ARGS
    ${OpenChemistry_DEFAULT_ARGS}
    -DENABLE_TESTS:BOOL=OFF
    -DCHEMKIT_BUILD_APPS:BOOL=OFF
    -DCHEMKIT_WITH_GRAPHICS:BOOL=OFF
    -DCHEMKIT_WITH_GUI:BOOL=OFF
    -DCHEMKIT_WITH_WEB:BOOL=OFF
  DEPENDS
    ${_deps}
  )
