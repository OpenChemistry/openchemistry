set(_build "${CMAKE_CURRENT_BINARY_DIR}/libmsym")

ExternalProject_Add(libmsym
  GIT_REPOSITORY "https://github.com/mcodev31/libmsym"
  GIT_TAG "0c47befe4a1cd05cbba1aa561b914be926e5ced7"
  DOWNLOAD_DIR ${download_dir}
  BINARY_DIR ${_build}
  CMAKE_CACHE_ARGS
    ${OpenChemistry_DEFAULT_ARGS}
  CMAKE_ARGS
    -DBUILD_SHARED_LIBS:BOOL=${BUILD_SHARED_LIBS}
    -DMSYM_NO_VLA_SUPPORT:BOOL=TRUE
    -DCMAKE_INSTALL_PREFIX:PATH=<INSTALL_DIR>
  )
