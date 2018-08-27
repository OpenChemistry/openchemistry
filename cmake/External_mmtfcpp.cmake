# Note that Open Babel is GPLv2 only licensed, one particular problem this
# presents is that GPLv2 is incompatible with Apachev2 (MongoDB client lib)
# along with the standard concern over the viral nature of the license when
# linked to. Generally aiming to restrict it to calls in a separate process,
# where linking must take place a utility binary should be used in a separate
# process.

unset(_deps)
add_optional_deps(_deps "msgpackc")

get_filename_component(_self_dir ${CMAKE_CURRENT_LIST_FILE} PATH)

ExternalProject_Add(mmtfcpp
  DOWNLOAD_DIR ${download_dir}
  URL ${mmtfcpp_url}
  URL_MD5 ${mmtfcpp_md5}
  CMAKE_CACHE_ARGS
    ${OpenChemistry_DEFAULT_ARGS}
  DEPENDS
    ${_deps}
  PATCH_COMMAND ${CMAKE_COMMAND} -E copy_if_different
    "${_self_dir}/header_library.CMakeLists.txt"
    "<SOURCE_DIR>/CMakeLists.txt"
)
