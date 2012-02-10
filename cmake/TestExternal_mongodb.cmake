file(WRITE "${CMAKE_CURRENT_BINARY_DIR}/MongoTest.CMakeLists.txt" "
cmake_minimum_required(VERSION 2.8.7)
project(mongotest)

set(Boost_USE_STATIC_LIBS ON)
find_package(Boost COMPONENTS filesystem system thread)
# program_options
message(\"BOOST_ROOT='\${BOOST_ROOT}'\")
message(\"Boost_INCLUDE_DIR='\${Boost_INCLUDE_DIR}'\")
message(\"Boost_LIBRARIES='\${Boost_LIBRARIES}'\")

include_directories(\${Boost_INCLUDE_DIR})
include_directories(\${MongoDB_INCLUDE_DIR})
#include_directories(\${PCRE_INCLUDE_DIR})

add_definitions(
  \"/D_CRT_SECURE_NO_WARNINGS\"
  \"/D_UNICODE\"
  \"/DBOOST_ALL_NO_LIB\"
  )

find_library(MongoDB_LIBRARY mongoclient)

if(WIN32)
  set(platform_libs ws2_32.lib)
  # psapi.lib
endif()

add_executable(mongotest
  \${CMAKE_CURRENT_SOURCE_DIR}/mongotest.cpp
  )
target_link_libraries(mongotest
  \${MongoDB_LIBRARY}
  \${Boost_LIBRARIES}
  \${platform_libs}
  )
install(TARGETS mongotest
  DESTINATION bin)
")


file(WRITE "${CMAKE_CURRENT_BINARY_DIR}/MongoTest.mongotest.cpp" "
#include \"client/dbclient.h\"

using namespace mongo;

int main(const int argc, const char* argv[]) {
  try {
    DBClientConnection c;
    c.connect(\"localhost\");
    cout << \"connect worked\" << endl;
  } catch( DBException &e ) {
    cout << \"connect failed: \" << e.what() << endl;
  }

  return 0;
}
")


ExternalProject_Add(MongoTest
  DOWNLOAD_COMMAND ""
  PATCH_COMMAND ${CMAKE_COMMAND} -E copy_if_different
    "${CMAKE_CURRENT_BINARY_DIR}/MongoTest.CMakeLists.txt"
    "<SOURCE_DIR>/CMakeLists.txt"
    COMMAND ${CMAKE_COMMAND} -E copy_if_different
    "${CMAKE_CURRENT_BINARY_DIR}/MongoTest.mongotest.cpp"
    "<SOURCE_DIR>/mongotest.cpp"
  CMAKE_ARGS
    -DCMAKE_INSTALL_PREFIX:PATH=<INSTALL_DIR>
    -DBOOST_ROOT:PATH=${BOOST_ROOT}
    #-DBoost_INCLUDE_DIR:PATH=${Boost_INCLUDE_DIR}
    -DMongoDB_INCLUDE_DIR:PATH=${MongoDB_INCLUDE_DIR}
    -DMongoDB_LIBRARY:FILEPATH=${MongoDB_LIBRARY}
    #-DPCRE_INCLUDE_DIR:PATH=${PCRE_INCLUDE_DIR}
  DEPENDS
    MongoCxxLib
)

ExternalProject_Get_Property(MongoTest source_dir)
set(MongoTest_SOURCE_DIR ${source_dir})

message("MongoTest_SOURCE_DIR='${MongoTest_SOURCE_DIR}'")
