cmake_minimum_required(VERSION 2.8.5)
project(OpenChemistry CXX)

set(CMAKE_MODULE_PATH "${CMAKE_CURRENT_SOURCE_DIR}/cmake"
  ${CMAKE_MODULE_PATH})

# Set up some standard defaults, these will be passed down into external the
# projects.
include(BuildType)
include(BuildLocation)

include(ExternalProject)
include(projects)
include(download_dir)

# Set up a few default arguments for all projects, such as the install prefix,
# CMake prefix path and the runtime/library output directories.
set(OpenChemistry_INSTALL_PREFIX "${OpenChemistry_BINARY_DIR}/prefix")
set(OpenChemistry_DEFAULT_ARGS
  "-DCMAKE_PREFIX_PATH:PATH=${OpenChemistry_INSTALL_PREFIX}"
  "-DCMAKE_INSTALL_PREFIX:PATH=${OpenChemistry_INSTALL_PREFIX}"
  "-DCMAKE_RUNTIME_OUTPUT_DIRECTORY:PATH=${CMAKE_RUNTIME_OUTPUT_DIRECTORY}"
  "-DCMAKE_LIBRARY_OUTPUT_DIRECTORY:PATH=${CMAKE_LIBRARY_OUTPUT_DIRECTORY}")

# If there is a CMAKE_BUILD_TYPE it is important to ensure it is passed down.
if(CMAKE_BUILD_TYPE)
  list(APPEND OpenChemistry_DEFAULT_ARGS
    "-DCMAKE_BUILD_TYPE:STRING=${CMAKE_BUILD_TYPE}")
endif()

add_subdirectory(tpl)

#include(TestExternal_mongodb)

# Now for the actual open chemistry projects!

# First the Qt dependent components.
find_package(Qt4 4.7 REQUIRED)
list(APPEND OpenChemistry_DEFAULT_ARGS
  "-DQT_QMAKE_EXECUTABLE:PATH=${QT_QMAKE_EXECUTABLE}")
include(External_avogadrolibs)
include(External_openqube)
include(External_molequeue)
include(External_chemkit)

# These things are dependent on VTK and Qt.
find_package(VTK REQUIRED)
list(APPEND OpenChemistry_DEFAULT_ARGS
  "-DVTK_DIR:PATH=${VTK_DIR}")
include(External_chemdata)
