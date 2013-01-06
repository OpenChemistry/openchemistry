# Note that Open Babel is GPLv2 only licensed, one particular problem this
# presents is that GPLv2 is incompatible with Apachev2 (MongoDB client lib)
# along with the standard concern over the viral nature of the license when
# linked to. Generally aiming to restrict it to calls in a separate process,
# where linking must take place a utility binary should be used in a separate
# process.
set(_source "${CMAKE_CURRENT_SOURCE_DIR}/openbabel")
set(_build "${CMAKE_CURRENT_BINARY_DIR}/openbabel")

ExternalProject_Add(openbabel
  DOWNLOAD_DIR ${download_dir}
  SOURCE_DIR ${_source}
  BINARY_DIR ${_build}
  URL ${openbabel_url}
  URL_MD5 ${openbabel_md5}
  CMAKE_ARGS
    -DCMAKE_INSTALL_PREFIX:PATH=${OpenChemistry_INSTALL_PREFIX}
  )
