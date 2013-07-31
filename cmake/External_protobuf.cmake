set(_source "${CMAKE_CURRENT_SOURCE_DIR}/protobuf")
set(_build "${CMAKE_CURRENT_BINARY_DIR}/protobuf")

ExternalProject_Add(protobuf
  SOURCE_DIR ${_source}
  BINARY_DIR ${_build}
  CMAKE_CACHE_ARGS
    ${OpenChemistry_DEFAULT_ARGS}
  )
