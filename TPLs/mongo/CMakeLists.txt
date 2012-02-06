cmake_minimum_required(VERSION 2.8)
project(MongoSuperBuild NONE)

include(ExternalProject)


if(WIN32)
  set(boost_cmds
    CONFIGURE_COMMAND <SOURCE_DIR>/bootstrap.bat
    BUILD_COMMAND <SOURCE_DIR>/b2
    INSTALL_COMMAND <SOURCE_DIR>/b2 --prefix=<INSTALL_DIR> install
  )
  set(boost_include_suffix "include/boost-1_48")
else()
  set(boost_cmds
    CONFIGURE_COMMAND <SOURCE_DIR>/bootstrap.sh --prefix=<INSTALL_DIR>
    BUILD_COMMAND <SOURCE_DIR>/b2
    INSTALL_COMMAND <SOURCE_DIR>/b2 install
  )
  set(boost_include_suffix "include")
endif()

ExternalProject_Add(Boost
  URL http://sourceforge.net/projects/boost/files/boost/1.48.0/boost_1_48_0.tar.gz/download
  URL_MD5 313a11e97eb56eb7efd18325354631be
  ${boost_cmds}
  BUILD_IN_SOURCE 1
)

ExternalProject_Get_Property(Boost install_dir source_dir)
set(Boost_INSTALL_DIR ${install_dir})
set(Boost_SOURCE_DIR ${source_dir})
set(Boost_INCLUDE_DIR "${Boost_INSTALL_DIR}/${boost_include_suffix}")

message("Boost_INCLUDE_DIR='${Boost_INCLUDE_DIR}'")
message("Boost_INSTALL_DIR='${Boost_INSTALL_DIR}'")
message("Boost_SOURCE_DIR='${Boost_SOURCE_DIR}'")


ExternalProject_Add(PCRE
  URL ftp://ftp.csx.cam.ac.uk/pub/software/programming/pcre/pcre-8.21.tar.gz
  URL_MD5 b8c9469717262a1e486cffc288b28283
  CMAKE_ARGS
    -DCMAKE_INSTALL_PREFIX:PATH=<INSTALL_DIR>
)

ExternalProject_Get_Property(PCRE install_dir source_dir)
set(PCRE_INSTALL_DIR ${install_dir})
set(PCRE_SOURCE_DIR ${source_dir})
set(PCRE_INCLUDE_DIR "${PCRE_INSTALL_DIR}/include")

message("PCRE_INCLUDE_DIR='${PCRE_INCLUDE_DIR}'")
message("PCRE_INSTALL_DIR='${PCRE_INSTALL_DIR}'")
message("PCRE_SOURCE_DIR='${PCRE_SOURCE_DIR}'")


file(WRITE "${CMAKE_CURRENT_BINARY_DIR}/MongoCxxLib.CMakeLists.txt" "
cmake_minimum_required(VERSION 2.8.7)
project(mongoclient)

find_package(Boost)

include_directories(\${Boost_INCLUDE_DIR})
include_directories(\${PCRE_INCLUDE_DIR})
include_directories(\${CMAKE_CURRENT_SOURCE_DIR})

add_definitions(
  \"/D_CRT_SECURE_NO_WARNINGS\"
  \"/D_UNICODE\"
  )

add_library(mongoclient
  \${CMAKE_CURRENT_SOURCE_DIR}/client/mongo_client_lib.cpp
  )
# target_link_libraries(mongoclient)
install(TARGETS mongoclient
  DESTINATION lib)
")

ExternalProject_Add(MongoCxxLib
  URL http://downloads.mongodb.org/src/mongodb-src-r2.0.2.tar.gz
  URL_MD5 5dcf819249955a3e9cc61a341e45403a
  PATCH_COMMAND ${CMAKE_COMMAND} -E copy_if_different
    "${CMAKE_CURRENT_BINARY_DIR}/MongoCxxLib.CMakeLists.txt"
    "<SOURCE_DIR>/CMakeLists.txt"
    COMMAND ${CMAKE_COMMAND} -E copy_if_different
    "${CMAKE_CURRENT_SOURCE_DIR}/connpool.cpp.patch"
    "<SOURCE_DIR>/client/connpool.cpp"
    COMMAND ${CMAKE_COMMAND} -E copy_if_different
    "${CMAKE_CURRENT_SOURCE_DIR}/text.cpp.patch"
    "<SOURCE_DIR>/util/text.cpp"
  CMAKE_ARGS
    -DCMAKE_INSTALL_PREFIX:PATH=<INSTALL_DIR>
    -DBoost_INCLUDE_DIR:PATH=${Boost_INCLUDE_DIR}
    -DPCRE_INCLUDE_DIR:PATH=${PCRE_INCLUDE_DIR}
  DEPENDS
    Boost
    PCRE
)

ExternalProject_Get_Property(MongoCxxLib source_dir)
set(MongoCxxLib_SOURCE_DIR ${source_dir})

message("MongoCxxLib_SOURCE_DIR='${MongoCxxLib_SOURCE_DIR}'")
