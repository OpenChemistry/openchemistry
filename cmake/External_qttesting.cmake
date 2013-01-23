# Pick out the modules used in MongoChem and AvogadroLibs only.
set(_source "${CMAKE_CURRENT_SOURCE_DIR}/qttesting")
set(_build "${CMAKE_CURRENT_BINARY_DIR}/qttesting")

ExternalProject_Add(qttesting
  SOURCE_DIR ${_source}
  BINARY_DIR ${_build}
  CMAKE_CACHE_ARGS
    ${OpenChemistry_DEFAULT_ARGS}
    -DQT_TESTING_INSTALL_DEVELOPMENT:BOOL=ON
  )
