# Pick out the modules used in MongoChem and AvogadroLibs only.
set(_source "${CMAKE_CURRENT_SOURCE_DIR}/jkqtplotter")
set(_build "${CMAKE_CURRENT_BINARY_DIR}/jkqtplotter")
set(_install "${OpenChemistry_INSTALL_PREFIX}")

unset(_deps)

find_package(Qt6 COMPONENTS Widgets REQUIRED)

ExternalProject_Add(jkqtplotter
  SOURCE_DIR ${_source}
  BINARY_DIR ${_build}
  INSTALL_DIR ${_install}
  CMAKE_CACHE_ARGS
  -DJKQtPlotter_BUILD_TESTS:BOOL=OFF
  -DJKQtPlotter_BUILD_TOOLS:BOOL=OFF
  -DJKQtPlotter_BUILD_EXAMPLES:BOOL=OFF
  -DJKQtPlotter_BUILD_LIB_JKQTFASTPLOTTER:BOOL=OFF
  -DCMAKE_CXX_VISIBILITY_PRESET:STRING=default
  -DCMAKE_POLICY_VERSION_MINIMUM:STRING=3.10
  ${OpenChemistry_DEFAULT_ARGS}
  ${OpenChemistry_THIRDPARTYLIBS_ARGS}
  DEPENDS
    ${_deps}
  )
