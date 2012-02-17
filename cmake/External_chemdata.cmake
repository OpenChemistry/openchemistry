set(_source "${CMAKE_CURRENT_SOURCE_DIR}/chemdata")
set(_build "${CMAKE_CURRENT_BINARY_DIR}/chemdata")

ExternalProject_Add(chemdata
  SOURCE_DIR ${_source}
  BINARY_DIR ${_build}
  CMAKE_ARGS
    ${OpenChemistry_DEFAULT_ARGS}
  DEPENDS
    MongoCxxLib
    chemkit)
