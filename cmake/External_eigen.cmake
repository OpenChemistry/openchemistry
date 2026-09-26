set(eigen_build "${CMAKE_CURRENT_BINARY_DIR}/eigen")

ExternalProject_Add(eigen
  DOWNLOAD_DIR ${download_dir}
  BINARY_DIR ${eigen_build}
  URL ${eigen_url}
  URL_HASH SHA256=${eigen_sha256}
  CMAKE_CACHE_ARGS
    ${OpenChemistry_DEFAULT_ARGS}
    -DEIGEN_BUILD_DOC:BOOL=OFF
    -DBUILD_TESTING:BOOL=OFF
    # We use Eigen header-only, so none of these are wanted. They default to ON
    # because Eigen is built here as its own top-level project, and the BLAS and
    # LAPACK ones drag in a Fortran compiler for code nothing links against.
    -DEIGEN_BUILD_BLAS:BOOL=OFF
    -DEIGEN_BUILD_LAPACK:BOOL=OFF
    -DEIGEN_BUILD_DEMOS:BOOL=OFF
  )
