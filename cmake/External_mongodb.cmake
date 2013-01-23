file(WRITE "${CMAKE_CURRENT_BINARY_DIR}/mongodb.CMakeLists.txt" "
cmake_minimum_required(VERSION 2.8.7)
project(mongoclient)

# On Windows we always need this set other FindBoost will fail!
if(NOT BUILD_SHARED_LIBS OR WIN32)
  set(Boost_USE_STATIC_LIBS ON)
endif()
find_package(Boost COMPONENTS filesystem system thread chrono)
message(\"BOOST_ROOT='\${BOOST_ROOT}'\")
message(\"Boost_INCLUDE_DIR='\${Boost_INCLUDE_DIR}'\")
message(\"Boost_LIBRARIES='\${Boost_LIBRARIES}'\")

set(mongo_root_dir "\${CMAKE_CURRENT_SOURCE_DIR}/src")
set(mongo_src_dir "\${mongo_root_dir}/mongo")

include_directories(\${Boost_INCLUDE_DIR})
include_directories(\${PCRE_INCLUDE_DIR})
include_directories(\${mongo_root_dir})
include_directories(\${mongo_src_dir})

add_definitions(
  \"/D_CRT_SECURE_NO_WARNINGS\"
  \"/D_UNICODE\"
  \"/DBOOST_ALL_NO_LIB\"
  )

set(_client_lib_src "\${mongo_src_dir}/client/mongo_client_lib.cpp")

# Build static on Windows
if(WIN32)
  add_library(mongoclient STATIC
    \${_client_lib_src}
    )
else()
  add_library(mongoclient
    \${_client_lib_src}
    )
endif()

target_link_libraries(mongoclient \${Boost_LIBRARIES})

if(WIN32)
  target_link_libraries(mongoclient ws2_32)
endif()

install(TARGETS mongoclient
  DESTINATION lib)

# \"Minimum\" set of headers needed for the MongoDB client:
file(GLOB mongo_headers \${mongo_src_dir}/*.h \${mongo_src_dir}/*.hpp)
install(FILES \${mongo_headers} DESTINATION include/mongo)

foreach(dir
  base
  bson
  bson/util
  client
  db
  platform
  util
  util/concurrency
  util/mongoutils
  util/net
)
  file(GLOB mongo_headers \${mongo_src_dir}/\${dir}/*.h \${mongo_src_dir}/\${dir}/*.hpp)
  install(FILES \${mongo_headers} DESTINATION include/mongo/\${dir})
endforeach()
")

get_filename_component(_self_dir ${CMAKE_CURRENT_LIST_FILE} PATH)

ExternalProject_Add(mongodb
  DOWNLOAD_DIR ${download_dir}
  URL ${mongodb_url}
  URL_MD5 ${mongodb_md5}
  BINARY_DIR "${CMAKE_CURRENT_BINARY_DIR}/mongoclient"
  INSTALL_DIR "${OpenChemistry_INSTALL_PREFIX}"
  PATCH_COMMAND ${CMAKE_COMMAND} -E copy_if_different
    "${CMAKE_CURRENT_BINARY_DIR}/mongodb.CMakeLists.txt"
    "<SOURCE_DIR>/CMakeLists.txt"
  CMAKE_CACHE_ARGS
     ${OpenChemistry_THIRDPARTYLIBS_ARGS}
    -DCMAKE_INSTALL_PREFIX:PATH=<INSTALL_DIR>
    -DBUILD_SHARED_LIBS:BOOL=${BUILD_SHARED_LIBS}
    -DPCRE_INCLUDE_DIR:PATH=${PCRE_INCLUDE_DIR}
  DEPENDS
    boost
    pcre
)
