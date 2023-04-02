set(_source "${CMAKE_CURRENT_SOURCE_DIR}/avogadroapp")
set(_build "${CMAKE_CURRENT_BINARY_DIR}/avogadroapp")

set(_deps "avogadrolibs")
if(ENABLE_TESTING)
  add_optional_deps(_deps "qttesting")
endif()

# FIXME The RPC code should be moved out of MoleQueue.
if(BUILD_MOLEQUEUE)
  set(ENABLE_RPC "ON")
else()
  set(ENABLE_RPC "OFF")
endif()

ExternalProject_Add(avogadroapp
  SOURCE_DIR ${_source}
  BINARY_DIR ${_build}
  CMAKE_CACHE_ARGS
    -DAvogadro_ENABLE_RPC:BOOL=${ENABLE_RPC}
    ${OpenChemistry_DEFAULT_ARGS}
    ${OpenChemistry_THIRDPARTYLIBS_ARGS}
  DEPENDS
    ${_deps}
  )
