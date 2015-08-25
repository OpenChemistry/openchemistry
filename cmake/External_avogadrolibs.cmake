set(_source "${CMAKE_CURRENT_SOURCE_DIR}/avogadrolibs")
set(_build "${CMAKE_CURRENT_BINARY_DIR}/avogadrolibs")

unset(_deps)
if(BUILD_MOLEQUEUE)
  list(APPEND _deps "molequeue")
  set(_molequeue "ON")
else()
  set(_molequeue "OFF")
endif()
add_optional_deps(_deps "boost" "eigen" "glew" "hdf5" "VTK" "libmsym")
if(ENABLE_TESTING)
  add_optional_deps(_deps "gtest")
endif()
if(BUILD_AVOGADR_CLIENT_SERVER)
  add_optional_deps(_deps "protobuf" "protocall")
  set(_protocall "ON")
else()
  set(_protocall "OFF")
endif()

ExternalProject_Add(avogadrolibs
  SOURCE_DIR ${_source}
  BINARY_DIR ${_build}
  CMAKE_CACHE_ARGS
    ${OpenChemistry_DEFAULT_ARGS}
    ${OpenChemistry_THIRDPARTYLIBS_ARGS}
    -DUSE_MOLEQUEUE:BOOL=${_molequeue}
    -DUSE_PROTOCALL:BOOL=${_protocall}
  DEPENDS
    ${_deps}
  )

if(FORCE_STEP)
  ExternalProject_Add_Step(avogadrolibs forcebuild
    COMMAND ${CMAKE_COMMAND} -E echo "Force build of avogadrolibs"
    ${FORCE_STEP_ARGS}
    ALWAYS 1)
endif()
