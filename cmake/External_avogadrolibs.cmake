set(_source "${CMAKE_CURRENT_SOURCE_DIR}/avogadrolibs")
set(_build "${CMAKE_CURRENT_BINARY_DIR}/avogadrolibs")

unset(_deps)

list(APPEND _deps "spglib")

if(BUILD_MOLEQUEUE)
  list(APPEND _deps "molequeue")
  set(_molequeue "ON")
else()
  set(_molequeue "OFF")
endif()
add_optional_deps(_deps "eigen" "glew" "libmsym")
add_optional_deps(_deps "libarchive")

if(USE_VTK)
  add_optional_deps(_deps "VTK")
endif()

if(USE_PLOTTER)
  add_optional_deps(_deps "jkqtplotter")
endif()

if(USE_PYTHON)
  add_optional_deps(_deps "pybind11")
endif()

if(USE_HDF5)
  add_optional_deps(_deps "hdf5")
endif()

if(ENABLE_TESTING)
  add_optional_deps(_deps "gtest")
endif()

ExternalProject_Add(avogadrolibs
  SOURCE_DIR ${_source}
  BINARY_DIR ${_build}
  CMAKE_CACHE_ARGS
    ${OpenChemistry_DEFAULT_ARGS}
    ${OpenChemistry_THIRDPARTYLIBS_ARGS}
    -DUSE_MOLEQUEUE:BOOL=${_molequeue}
    -DUSE_VTK:BOOL=${USE_VTK}
    -DUSE_HDF5:BOOL=${USE_HDF5}
    -DBUILD_GPL_PLUGINS:BOOL=${BUILD_GPL_PLUGINS}
  DEPENDS
    ${_deps}
  )

if(FORCE_STEP)
  ExternalProject_Add_Step(avogadrolibs forcebuild
    COMMAND ${CMAKE_COMMAND} -E echo "Force build of avogadrolibs"
    ${FORCE_STEP_ARGS}
    ALWAYS 1)
endif()
