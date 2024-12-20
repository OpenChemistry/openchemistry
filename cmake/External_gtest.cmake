ExternalProject_Add(gtest
  DOWNLOAD_DIR ${download_dir}
  URL ${gtest_url}
  URL_SHA256 ${gtest_sha256}
  BINARY_DIR "${CMAKE_CURRENT_BINARY_DIR}/gtest"
  INSTALL_DIR "${OpenChemistry_INSTALL_PREFIX}"
  CMAKE_ARGS
    -DBUILD_SHARED_LIBS:BOOL=${BUILD_SHARED_LIBS}
    -DCMAKE_INSTALL_PREFIX:PATH=<INSTALL_DIR>
  )
