set(eigen_build "${CMAKE_CURRENT_BINARY_DIR}/eigen")

ExternalProject_Add(eigen
  DOWNLOAD_DIR ${download_dir}
  BINARY_DIR ${eigen_build}
  URL ${eigen_url}
  URL_MD5 ${eigen_md5}
  CMAKE_CACHE_ARGS
    ${OpenChemistry_DEFAULT_ARGS}
    -DEIGEN_BUILD_DOC:BOOL=OFF
    -DBUILD_TESTING:BOOL=OFF
  )
