cmake_minimum_required(VERSION 2.8.7)
project(OpenChemistry NONE)

set(CMAKE_MODULE_PATH "${CMAKE_CURRENT_SOURCE_DIR}/cmake"
  ${CMAKE_MODULE_PATH})

include(ExternalProject)
include(projects)
include(download_dir)

set(OpenChemistry_INSTALL_PREFIX "${OpenChemistry_BINARY_DIR}/prefix")

add_subdirectory(tpl)

include(TestExternal_mongodb)

# Now for the actual open chemistry projects!
include(External_openqube)
