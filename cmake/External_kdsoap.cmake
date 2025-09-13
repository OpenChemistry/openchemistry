set(kdsoap_build "${CMAKE_CURRENT_BINARY_DIR}/kdsoap")

ExternalProject_Add(kdsoap
  DOWNLOAD_DIR ${download_dir}
  BINARY_DIR ${kdsoap_build}
  URL ${kdsoap_url}
  URL_HASH SHA256=${kdsoap_sha256}
  CMAKE_CACHE_ARGS
    ${OpenChemistry_DEFAULT_ARGS}
  )
