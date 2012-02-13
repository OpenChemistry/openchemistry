set(eigen_source "${CMAKE_CURRENT_SOURCE_DIR}/eigen")
set(eigen_build "${CMAKE_CURRENT_BINARY_DIR}/eigen")

ExternalProject_Add(eigen
  SOURCE_DIR ${eigen_source}
  BINARY_DIR ${eigen_build}
  CMAKE_ARGS
    -DCMAKE_INSTALL_PREFIX:PATH=${OpenChemistry_INSTALL_PREFIX}
    ${avogadro_build_vars}
  )
