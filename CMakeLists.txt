cmake_minimum_required(VERSION 2.8.7)
project(OpenChemistry NONE)

set(CMAKE_MODULE_PATH "${CMAKE_CURRENT_SOURCE_DIR}/cmake"
  ${CMAKE_MODULE_PATH})

include(ExternalProject)
include(projects)
include(download_dir)

# Set up a few default arguments for all projects
set(OpenChemistry_INSTALL_PREFIX "${OpenChemistry_BINARY_DIR}/prefix")
set(OpenChemistry_DEFAULT_ARGS
  "-DCMAKE_PREFIX_PATH:PATH=${OpenChemistry_INSTALL_PREFIX}"
  "-DCMAKE_INSTALL_PREFIX:PATH=${OpenChemistry_INSTALL_PREFIX}")

add_subdirectory(tpl)

include(TestExternal_mongodb)

# Now for the actual open chemistry projects!
include(External_openqube)
