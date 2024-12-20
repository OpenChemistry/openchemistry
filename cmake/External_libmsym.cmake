set(_build "${CMAKE_CURRENT_BINARY_DIR}/libmsym")
set(libmsym_source  "${CMAKE_CURRENT_BINARY_DIR}/libmsym-0.2.3-paper")

ExternalProject_Add(libmsym
  DOWNLOAD_DIR ${download_dir}
  SOURCE_DIR "${libmsym_source}"
  URL ${libmsym_url}
  URL_SHA256 ${libmsym_sha256}
  CMAKE_CACHE_ARGS
    ${OpenChemistry_DEFAULT_ARGS}
  CMAKE_ARGS
    -DBUILD_SHARED_LIBS:BOOL=${BUILD_SHARED_LIBS}
    -DMSYM_NO_VLA_SUPPORT:BOOL=TRUE
    -DCMAKE_INSTALL_PREFIX:PATH=<INSTALL_DIR>
    -DINSTALL_BIN_DIR:PATH=bin
)
