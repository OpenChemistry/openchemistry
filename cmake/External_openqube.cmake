set(openqube_source "${CMAKE_CURRENT_SOURCE_DIR}/openqube")
set(openqube_build "${CMAKE_CURRENT_BINARY_DIR}/openqube")

ExternalProject_Add(openqube
  SOURCE_DIR ${openqube_source}
  BINARY_DIR ${openqube_build}
  CMAKE_ARGS
    ${OpenChemistry_DEFAULT_ARGS}
    -DENABLE_TESTS:BOOL=OFF
  DEPENDS
    eigen)

if(FORCE_STEP)
  ExternalProject_Add_Step(openqube forcebuild
    COMMAND ${CMAKE_COMMAND} -E echo "Force build of openqube"
    ${FORCE_STEP_ARGS}
    ALWAYS 1)
endif()
