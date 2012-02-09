cmake_minimum_required(VERSION 2.8.7)
project(OpenChemistry NONE)

set(CMAKE_MODULE_PATH "${CMAKE_CURRENT_SOURCE_DIR}/cmake"
  ${CMAKE_MODULE_PATH})

include(ExternalProject)
include(projects)
include(download_dir)

option(USE_SYSTEM_BOOST "Should we use the system Boost?" OFF)
option(USE_SYSTEM_MONGODB "Should we use the system mongoDB?" OFF)
option(USE_SYSTEM_PCRE "Should we use the system PCRE?" OFF)

if(USE_SYSTEM_BOOST)
  find_package(Boost REQUIRED)
else()
  include(External_boost)
endif()

if(USE_SYSTEM_PCRE)
  message(FATAL_ERROR "find_package(PCRE) is not yet implemented")
else()
  include(External_pcre)
endif()

if(USE_SYSTEM_MONGODB)
  message(FATAL_ERROR "find_package(mongoDB) is not yet implemented")
else()
  include(External_mongodb)
endif()

include(TestExternal_mongodb)
