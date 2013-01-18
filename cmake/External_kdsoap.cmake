set(kdsoap_build "${CMAKE_CURRENT_BINARY_DIR}/kdsoap")

ExternalProject_Add(kdsoap
  DOWNLOAD_DIR ${download_dir}
  BINARY_DIR ${kdsoap_build}
  URL ${kdsoap_url}
  URL_MD5 ${kdsoap_md5}
  CMAKE_CACHE_ARGS
    ${OpenChemistry_DEFAULT_ARGS}
  )
