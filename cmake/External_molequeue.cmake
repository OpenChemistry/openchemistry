set(molequeue_source "${CMAKE_CURRENT_SOURCE_DIR}/molequeue")
set(molequeue_build "${CMAKE_CURRENT_BINARY_DIR}/molequeue")

ExternalProject_Add(molequeue
  SOURCE_DIR ${molequeue_source}
  BINARY_DIR ${molequeue_build}
  CMAKE_ARGS
    ${OpenChemistry_DEFAULT_ARGS}
    -DENABLE_TESTS:BOOL=OFF)
