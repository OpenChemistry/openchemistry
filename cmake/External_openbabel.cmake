# Note that Open Babel is GPLv2 only licensed, one particular problem this
# presents is that GPLv2 is incompatible with Apachev2 (MongoDB client lib)
# along with the standard concern over the viral nature of the license when
# linked to. Generally aiming to restrict it to calls in a separate process,
# where linking must take place a utility binary should be used in a separate
# process.
set(_build "${CMAKE_CURRENT_BINARY_DIR}/openbabel")

unset(_deps)
add_optional_deps(_deps "zlib" "libxml2")

ExternalProject_Add(openbabel
  DOWNLOAD_DIR ${download_dir}
  BINARY_DIR ${_build}
  URL ${openbabel_url}
  URL_MD5 ${openbabel_md5}
  CMAKE_CACHE_ARGS
    ${OpenChemistry_DEFAULT_ARGS}
    -DENABLE_TESTS:BOOL=OFF
    -DBUILD_GUI:BOOL=OFF
    -DOPTIMIZE_NATIVE:BOOL=OFF
    -DOB_USE_PREBUILT_BINARIES:BOOL=OFF
    -DENABLE_VERSIONED_FORMATS:BOOL=OFF
    -DWITH_JSON:BOOL=OFF
    -DWITH_MAEPARSER:BOOL=OFF
    ${OpenChemistry_THIRDPARTYLIBS_ARGS}
  DEPENDS
    ${_deps}
  )
