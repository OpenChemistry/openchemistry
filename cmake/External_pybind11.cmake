set(_source "${CMAKE_CURRENT_SOURCE_DIR}/pybind11")
set(_build "${CMAKE_CURRENT_BINARY_DIR}/pybind11")

ExternalProject_Add(pybind11
  SOURCE_DIR ${_source}
  BINARY_DIR ${_build}
  CMAKE_CACHE_ARGS
    ${OpenChemistry_DEFAULT_ARGS}
    ${OpenChemistry_THIRDPARTYLIBS_ARGS}
    -DPYBIND11_TEST:BOOL=OFF
  )
