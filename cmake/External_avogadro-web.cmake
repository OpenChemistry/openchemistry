set(_source "${CMAKE_CURRENT_SOURCE_DIR}/avogadro-web")
set(_build "${CMAKE_CURRENT_BINARY_DIR}/avogadro-web")

option(Avogadro_ENABLE_RPC "Enable the desktop RPC server" OFF)
if(Avogadro_ENABLE_RPC)
  message(FATAL_ERROR "AVOGADRO_WEB_EDITOR requires Avogadro_ENABLE_RPC=OFF")
endif()

ExternalProject_Add(avogadro-web
  SOURCE_DIR ${_source}
  BINARY_DIR ${_build}
  CMAKE_CACHE_ARGS
    ${OpenChemistry_DEFAULT_ARGS}
    ${OpenChemistry_THIRDPARTYLIBS_ARGS}
  DEPENDS avogadrolibs
  )
