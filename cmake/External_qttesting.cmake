# Pick out the modules used in MongoChem and AvogadroLibs only.
set(_source "${CMAKE_CURRENT_SOURCE_DIR}/qttesting")
set(_build "${CMAKE_CURRENT_BINARY_DIR}/qttesting")

set(CMAKE_CXX_VISIBILITY_PRESET "default")
set(CMAKE_VISIBILITY_INLINES_HIDDEN 0)

ExternalProject_Add(qttesting
  SOURCE_DIR ${_source}
  BINARY_DIR ${_build}
  CMAKE_CACHE_ARGS
    ${OpenChemistry_DEFAULT_ARGS}
    -DQT_TESTING_INSTALL_DEVELOPMENT:BOOL=ON
    -DQtTesting_QT_VERSION:STRING=${QT_VERSION}
  )
