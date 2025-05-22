set(_build "${CMAKE_CURRENT_BINARY_DIR}/libmsym")
set(libmsym_source  "${CMAKE_CURRENT_BINARY_DIR}/libmsym-0.2.3-paper")

ExternalProject_Add(libmsym
  DOWNLOAD_DIR ${download_dir}
  SOURCE_DIR "${libmsym_source}"
  URL ${libmsym_url}
  URL_MD5 ${libmsym_md5}
  CMAKE_CACHE_ARGS
    ${OpenChemistry_DEFAULT_ARGS}
  CMAKE_ARGS
    -DBUILD_SHARED_LIBS:BOOL=${BUILD_SHARED_LIBS}
    -DMSYM_NO_VLA_SUPPORT:BOOL=TRUE
    -DCMAKE_INSTALL_PREFIX:PATH=<INSTALL_DIR>
    -DCMAKE_POLICY_VERSION_MINIMUM=3.5
    -DINSTALL_BIN_DIR:PATH=bin
)
