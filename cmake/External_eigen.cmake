set(eigen_source "${CMAKE_CURRENT_SOURCE_DIR}/eigen")
set(eigen_build "${CMAKE_CURRENT_BINARY_DIR}/eigen")

ExternalProject_Add(eigen
  DOWNLOAD_DIR ${download_dir}
  SOURCE_DIR ${eigen_source}
  BINARY_DIR ${eigen_build}
  URL ${eigen_url}
  URL_MD5 ${eigen_md5}
  CMAKE_ARGS
    -DCMAKE_INSTALL_PREFIX:PATH=${OpenChemistry_INSTALL_PREFIX}
  )
