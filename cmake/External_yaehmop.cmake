set(_source "${CMAKE_CURRENT_SOURCE_DIR}/yaehmop/tightbind")
set(_build "${CMAKE_CURRENT_BINARY_DIR}/yaehmop")
set(_install "${OpenChemistry_INSTALL_PREFIX}")

unset(_deps)

ExternalProject_Add(yaehmop
  SOURCE_DIR ${_source}
  BINARY_DIR ${_build}
  INSTALL_DIR ${_install}
  CMAKE_CACHE_ARGS
    ${OpenChemistry_DEFAULT_ARGS}
  DEPENDS
    ${_deps}
  )
