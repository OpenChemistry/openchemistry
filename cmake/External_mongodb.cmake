file(WRITE "${CMAKE_CURRENT_BINARY_DIR}/MongoCxxLib.CMakeLists.txt" "
cmake_minimum_required(VERSION 2.8.7)
project(mongoclient)

set(Boost_USE_STATIC_LIBS ON)
find_package(Boost COMPONENTS filesystem system thread)
# program_options
message(\"BOOST_ROOT='\${BOOST_ROOT}'\")
message(\"Boost_INCLUDE_DIR='\${Boost_INCLUDE_DIR}'\")
message(\"Boost_LIBRARIES='\${Boost_LIBRARIES}'\")

include_directories(\${Boost_INCLUDE_DIR})
include_directories(\${PCRE_INCLUDE_DIR})
include_directories(\${CMAKE_CURRENT_SOURCE_DIR})

add_definitions(
  \"/D_CRT_SECURE_NO_WARNINGS\"
  \"/D_UNICODE\"
  \"/DBOOST_ALL_NO_LIB\"
  )

add_library(mongoclient
  \${CMAKE_CURRENT_SOURCE_DIR}/client/mongo_client_lib.cpp
  )
# target_link_libraries(mongoclient)
install(TARGETS mongoclient
  DESTINATION lib)
")

get_filename_component(_self_dir ${CMAKE_CURRENT_LIST_FILE} PATH)

ExternalProject_Add(MongoCxxLib
  DOWNLOAD_DIR ${download_dir}
  URL ${mongodb_url}
  URL_MD5 ${mongodb_md5}
  BINARY_DIR "${CMAKE_CURRENT_BINARY_DIR}/mongoclient"
  INSTALL_DIR "${OpenChemistry_INSTALL_PREFIX}"
  PATCH_COMMAND ${CMAKE_COMMAND} -E copy_if_different
    "${CMAKE_CURRENT_BINARY_DIR}/MongoCxxLib.CMakeLists.txt"
    "<SOURCE_DIR>/CMakeLists.txt"
    COMMAND ${CMAKE_COMMAND} -E copy_if_different
    "${_self_dir}/mongodb.connpool.cpp.patch"
    "<SOURCE_DIR>/client/connpool.cpp"
    COMMAND ${CMAKE_COMMAND} -E copy_if_different
    "${_self_dir}/mongodb.text.cpp.patch"
    "<SOURCE_DIR>/util/text.cpp"
  CMAKE_ARGS
    -DCMAKE_INSTALL_PREFIX:PATH=<INSTALL_DIR>
    -DBOOST_ROOT:PATH=${BOOST_ROOT}
    -DPCRE_INCLUDE_DIR:PATH=${PCRE_INCLUDE_DIR}
  DEPENDS
    boost
    pcre
)

ExternalProject_Get_Property(MongoCxxLib install_dir source_dir)
set(MongoDB_INCLUDE_DIR "${source_dir}" CACHE INTERNAL "")
set(MongoDB_LIBRARY "${install_dir}/lib/${CMAKE_STATIC_LIBRARY_PREFIX}mongoclient${CMAKE_STATIC_LIBRARY_SUFFIX}" CACHE INTERNAL "")

message("MongoDB_INCLUDE_DIR='${MongoDB_INCLUDE_DIR}'")
message("MongoDB_LIBRARY='${MongoDB_LIBRARY}'")
