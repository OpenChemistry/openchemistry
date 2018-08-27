# An external project for spglib
set(msgpackc_source  "${CMAKE_CURRENT_BINARY_DIR}/msgpack-c-cpp-3.1.0")

get_filename_component(_self_dir ${CMAKE_CURRENT_LIST_FILE} PATH)

ExternalProject_Add(msgpackc
  DOWNLOAD_DIR ${download_dir}
  SOURCE_DIR "${msgpackc_source}"
  URL ${msgpackc_url}
  URL_MD5 ${msgpackc_md5}
  CMAKE_ARGS
    ${OpenChemistry_DEFAULT_ARGS}
  PATCH_COMMAND ${CMAKE_COMMAND} -E copy_if_different
    "${_self_dir}/header_library.CMakeLists.txt"
    "<SOURCE_DIR>/CMakeLists.txt"
)
