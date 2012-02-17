cmake_minimum_required(VERSION 2.8.7)
project(OpenChemistry CXX)

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

#include(TestExternal_mongodb)

# Now for the actual open chemistry projects!

# First the Qt dependent components.
find_package(Qt4 4.8 REQUIRED)
list(APPEND OpenChemistry_DEFAULT_ARGS
  "-DQMAKE_EXECUTABLE:PATH=${QMAKE_EXECUTABLE}")
include(External_openqube)
include(External_molequeue)
include(External_chemkit)

# These things are dependent on VTK and Qt.
find_package(VTK REQUIRED)
list(APPEND OpenChemistry_DEFAULT_ARGS
  "-DVTK_DIR:PATH=${VTK_DIR}")
include(External_chemdata)
