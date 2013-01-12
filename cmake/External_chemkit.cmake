set(_build "${CMAKE_CURRENT_BINARY_DIR}/chemkit")

unset(_deps)
add_optional_deps(_deps "boost" "eigen")

ExternalProject_Add(chemkit
  DOWNLOAD_DIR ${download_dir}
  BINARY_DIR ${_build}
  URL ${chemkit_url}
  URL_MD5 ${chemkit_md5}
  CMAKE_CACHE_ARGS
    ${OpenChemistry_DEFAULT_ARGS}
    ${OpenChemistry_THIRDPARTYLIBS_ARGS}
    -DENABLE_TESTS:BOOL=OFF
    -DCHEMKIT_BUILD_APPS:BOOL=OFF
    -DCHEMKIT_WITH_GRAPHICS:BOOL=OFF
    -DCHEMKIT_WITH_GUI:BOOL=OFF
    -DCHEMKIT_WITH_WEB:BOOL=OFF
  DEPENDS
    ${_deps}
  )
