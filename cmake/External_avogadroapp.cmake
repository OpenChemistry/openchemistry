set(_source "${CMAKE_CURRENT_SOURCE_DIR}/avogadroapp")
set(_build "${CMAKE_CURRENT_BINARY_DIR}/avogadroapp")

set(_deps "avogadrolibs")
if(ENABLE_TESTING AND NOT AVOGADRO_WEB_EDITOR)
  add_optional_deps(_deps "qttesting")
endif()
if(USE_PLOTTER)
  add_optional_deps(_deps "jkqtplotter")
endif()

# Enable RPC by default
set(_rpc_default ON)
if(AVOGADRO_WEB_EDITOR OR EMSCRIPTEN)
  set(_rpc_default OFF)
endif()
option(Avogadro_ENABLE_RPC "Enable the desktop RPC server" ${_rpc_default})
if(AVOGADRO_WEB_EDITOR AND Avogadro_ENABLE_RPC)
  message(FATAL_ERROR "AVOGADRO_WEB_EDITOR requires Avogadro_ENABLE_RPC=OFF")
endif()

ExternalProject_Add(avogadroapp
  SOURCE_DIR ${_source}
  BINARY_DIR ${_build}
  CMAKE_CACHE_ARGS
    -DAvogadro_ENABLE_RPC:BOOL=${Avogadro_ENABLE_RPC}
    -DUSE_PLOTTER:BOOL=${USE_PLOTTER}
    ${OpenChemistry_DEFAULT_ARGS}
    ${OpenChemistry_THIRDPARTYLIBS_ARGS}
  DEPENDS
    ${_deps}
  )
