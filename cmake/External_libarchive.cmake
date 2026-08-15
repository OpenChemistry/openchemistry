# An external project for libarchive
set(libarchive_source  "${CMAKE_CURRENT_BINARY_DIR}/libarchive-src")
set(libarchive_install "${OpenChemistry_INSTALL_PREFIX}")

get_filename_component(_self_dir ${CMAKE_CURRENT_LIST_FILE} PATH)

set(_libarchive_platform_args)
if(APPLE)
  # liblzma is not available on macOS 14.x, so disable it
  list(APPEND _libarchive_platform_args -DENABLE_LZMA=OFF)
endif()

if(EMSCRIPTEN)
  list(APPEND _libarchive_platform_args
    -DENABLE_ACL=OFF
    -DENABLE_BZip2=OFF
    -DENABLE_CAT=OFF
    -DENABLE_CPIO=OFF
    -DENABLE_ICONV=OFF
    -DENABLE_LIBB2=OFF
    -DENABLE_LIBXML2=OFF
    -DENABLE_LZ4=OFF
    -DENABLE_LZMA=OFF
    -DENABLE_OPENSSL=OFF
    -DENABLE_TAR=OFF
    -DENABLE_TEST=OFF
    -DENABLE_UNZIP=OFF
    -DENABLE_XATTR=OFF
    -DENABLE_ZLIB=OFF
    -DENABLE_ZSTD=OFF)
endif()

ExternalProject_Add(libarchive
  DOWNLOAD_DIR ${download_dir}
  SOURCE_DIR "${libarchive_source}"
  INSTALL_DIR "${libarchive_install}"
  URL ${libarchive_url}
  URL_HASH SHA256=${libarchive_sha256}
  BUILD_IN_SOURCE 1
  CMAKE_CACHE_ARGS
    ${OpenChemistry_DEFAULT_ARGS}
  CMAKE_ARGS
    -DCMAKE_POLICY_VERSION_MINIMUM=3.5
    -DCMAKE_INSTALL_PREFIX:PATH=<INSTALL_DIR>
    ${_libarchive_platform_args}
)
