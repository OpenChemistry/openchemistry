set(_source "${CMAKE_CURRENT_SOURCE_DIR}/mongochem")
set(_build "${CMAKE_CURRENT_BINARY_DIR}/mongochem")

unset(_deps)
unset(_build_options)
if(NOT USE_SYSTEM_MONGODB)
  list(APPEND _deps mongodb)
endif()
if(NOT USE_SYSTEM_VTK)
  list(APPEND _deps VTK)
endif()
# FIXME: When chemkit moves to being an optional dependency remove this.
set(USE_CHEMKIT TRUE)
if(USE_CHEMKIT AND NOT USE_SYSTEM_CHEMKIT)
  list(APPEND _deps chemkit)
endif()
# FIXME: Once Open Babel functionality is added, this can ensure optional build.
if(USE_OPENBABEL AND NOT USE_SYSTEM_OPENBABEL)
  list(APPEND _deps openbabel)
endif()

ExternalProject_Add(mongochem
  SOURCE_DIR ${_source}
  BINARY_DIR ${_build}
  CMAKE_ARGS
    ${OpenChemistry_DEFAULT_ARGS}
  DEPENDS
    ${_deps}
    molequeue)

if(FORCE_STEP)
  ExternalProject_Add_Step(mongochem forcebuild
    COMMAND ${CMAKE_COMMAND} -E echo "Force build of mongochem"
    ${FORCE_STEP_ARGS}
    ALWAYS 1)
endif()
