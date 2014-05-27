set(_source "${CMAKE_CURRENT_SOURCE_DIR}/avogadroapp")
set(_build "${CMAKE_CURRENT_BINARY_DIR}/avogadroapp")

set(_deps "avogadrolibs")
if(ENABLE_TESTING)
  add_optional_deps(_deps "qttesting")
endif()

ExternalProject_Add(avogadroapp
  SOURCE_DIR ${_source}
  BINARY_DIR ${_build}
  CMAKE_CACHE_ARGS
    ${OpenChemistry_DEFAULT_ARGS}
    ${OpenChemistry_THIRDPARTYLIBS_ARGS}
  DEPENDS
    ${_deps}
  )
