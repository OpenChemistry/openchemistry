set(molequeue_source "${CMAKE_CURRENT_SOURCE_DIR}/molequeue")
set(molequeue_build "${CMAKE_CURRENT_BINARY_DIR}/molequeue")

unset(_deps)
if(BUILD_MOLEQUEUE_UIT)
  set(_deps "kdsoap")
  set(_uit "ON")
else()
  set(_uit "OFF")
endif()

ExternalProject_Add(molequeue
  SOURCE_DIR ${molequeue_source}
  BINARY_DIR ${molequeue_build}
  CMAKE_CACHE_ARGS
    ${OpenChemistry_DEFAULT_ARGS}
    ${OpenChemistry_THIRDPARTYLIBS_ARGS}
    -DMoleQueue_USE_EZHPC_UIT:BOOL=${_uit}
  DEPENDS
    ${_deps}
  )

if(FORCE_STEP)
  ExternalProject_Add_Step(molequeue forcebuild
    COMMAND ${CMAKE_COMMAND} -E echo "Force build of molequeue"
    ${FORCE_STEP_ARGS}
    ALWAYS 1)
endif()
