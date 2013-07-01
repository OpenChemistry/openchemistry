set(_source "${CMAKE_CURRENT_SOURCE_DIR}/protocall")
set(_build "${CMAKE_CURRENT_BINARY_DIR}/protocall")

ExternalProject_Add(protocall
  SOURCE_DIR ${_source}
  BINARY_DIR ${_build}
  CMAKE_CACHE_ARGS
    ${OpenChemistry_DEFAULT_ARGS}
  )
