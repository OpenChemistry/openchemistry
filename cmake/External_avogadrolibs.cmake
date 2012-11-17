set(_source "${CMAKE_CURRENT_SOURCE_DIR}/avogadrolibs")
set(_build "${CMAKE_CURRENT_BINARY_DIR}/avogadrolibs")

unset(_deps)
if(NOT USE_SYSTEM_BOOST)
  list(APPEND _deps boost)
endif()
if(NOT USE_SYSTEM_EIGEN)
  list(APPEND _deps eigen)
endif()
if(NOT USE_SYSTEM_GLEW)
  list(APPEND _deps glew)
endif()
if(NOT USE_SYSTEM_GTEST)
  list(APPEND _deps gtest)
endif()
if(NOT USE_SYSTEM_HDF5)
  list(APPEND _deps hdf5)
endif()

ExternalProject_Add(avogadrolibs
  SOURCE_DIR ${_source}
  BINARY_DIR ${_build}
  CMAKE_ARGS
    ${OpenChemistry_DEFAULT_ARGS}
  DEPENDS
    molequeue
    ${_deps}
    )

if(FORCE_STEP)
  ExternalProject_Add_Step(avogadrolibs forcebuild
    COMMAND ${CMAKE_COMMAND} -E echo "Force build of avogadrolibs"
    ${FORCE_STEP_ARGS}
    ALWAYS 1)
endif()
