set(_source "${CMAKE_CURRENT_SOURCE_DIR}/mongochem")
set(_build "${CMAKE_CURRENT_BINARY_DIR}/mongochem")

set(_deps "molequeue")
add_optional_deps(_deps "mongodb" "VTK" "chemkit")
if(USE_OPENBABEL)
  add_optional_deps(_deps "openbabel")
endif()

ExternalProject_Add(mongochem
  SOURCE_DIR ${_source}
  BINARY_DIR ${_build}
  CMAKE_CACHE_ARGS
    ${OpenChemistry_DEFAULT_ARGS}
    ${OpenChemistry_THIRDPARTYLIBS_ARGS}
  DEPENDS
    ${_deps}
  )

if(FORCE_STEP)
  ExternalProject_Add_Step(mongochem forcebuild
    COMMAND ${CMAKE_COMMAND} -E echo "Force build of mongochem"
    ${FORCE_STEP_ARGS}
    ALWAYS 1)
endif()
