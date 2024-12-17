# mmtf-cpp depends on msgpack-c to be installed
# Licensed under MIT
unset(_deps)
add_optional_deps(_deps "msgpackc")

get_filename_component(_self_dir ${CMAKE_CURRENT_LIST_FILE} PATH)

ExternalProject_Add(mmtfcpp
  DOWNLOAD_DIR ${download_dir}
  URL ${mmtfcpp_url}
  URL_SHA256 ${mmtfcpp_sha256}
  CMAKE_CACHE_ARGS
    ${OpenChemistry_DEFAULT_ARGS}
  DEPENDS
    ${_deps}
  PATCH_COMMAND ${CMAKE_COMMAND} -E copy_if_different
    "${_self_dir}/header_library.CMakeLists.txt"
    "<SOURCE_DIR>/CMakeLists.txt"
)
