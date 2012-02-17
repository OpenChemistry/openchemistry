set(_source "${CMAKE_CURRENT_SOURCE_DIR}/chemkit")
set(_build "${CMAKE_CURRENT_BINARY_DIR}/chemkit")

ExternalProject_Add(chemkit
  SOURCE_DIR ${_source}
  BINARY_DIR ${_build}
  CMAKE_ARGS
    ${OpenChemistry_DEFAULT_ARGS}
    -DENABLE_TESTS:BOOL=OFF
    -DCHEMKIT_BUILD_APPS:BOOL=OFF
    -DCHEMKIT_WITH_GRAPHICS:BOOL=OFF
    -DCHEMKIT_WITH_GUI:BOOL=OFF
    -DCHEMKIT_WITH_WEB:BOOL=OFF
  DEPENDS
    eigen
    boost)
