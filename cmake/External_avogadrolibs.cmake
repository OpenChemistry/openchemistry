set(_source "${CMAKE_CURRENT_SOURCE_DIR}/avogadrolibs")
set(_build "${CMAKE_CURRENT_BINARY_DIR}/avogadrolibs")

unset(_deps)
if(NOT USE_SYSTEM_BOOST)
  list(APPEND _deps boost)
endif()
if(NOT USE_SYSTEM_EIGEN)
  list(APPEND _deps eigen)
endif()

ExternalProject_Add(avogadrolibs
  SOURCE_DIR ${_source}
  BINARY_DIR ${_build}
  CMAKE_ARGS
    ${OpenChemistry_DEFAULT_ARGS}
  DEPENDS
    ${_deps}
    )
