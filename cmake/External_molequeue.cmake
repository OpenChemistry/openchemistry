set(molequeue_source "${CMAKE_CURRENT_SOURCE_DIR}/molequeue")
set(molequeue_build "${CMAKE_CURRENT_BINARY_DIR}/molequeue")

ExternalProject_Add(molequeue
  SOURCE_DIR ${molequeue_source}
  BINARY_DIR ${molequeue_build}
  CMAKE_ARGS
    -DCMAKE_INSTALL_PREFIX:PATH=${OpenChemistry_INSTALL_PREFIX}
    ${avogadro_build_vars}
    -DENABLE_TESTS:BOOL=OFF)
