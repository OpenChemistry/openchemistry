set(_build "${CMAKE_CURRENT_BINARY_DIR}/libmsym")

ExternalProject_Add(libmsym
  GIT_REPOSITORY "https://github.com/mcodev31/libmsym"
  GIT_TAG "b7389ca5212a142edf3d727c350e407b93e3b83c"
  DOWNLOAD_DIR ${download_dir}
  BINARY_DIR ${_build}
  CMAKE_CACHE_ARGS
    ${OpenChemistry_DEFAULT_ARGS}
  )
