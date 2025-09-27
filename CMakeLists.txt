cmake_minimum_required(VERSION 3.19)
project(OpenChemistry CXX)

if(POLICY CMP0135)
  cmake_policy(SET CMP0135 NEW)
endif()

set(CMAKE_MODULE_PATH "${CMAKE_CURRENT_SOURCE_DIR}/cmake"
  ${CMAKE_MODULE_PATH})

# Set up some standard defaults, these will be passed down into external the
# projects.
include(BuildType)
include(BuildLocation)

include(ExternalProject)
include(projects)
# Allow choice of where download_dir should be.
option(DOWNLOAD_TO_SOURCE_DIR "Download external dependency source archives to CMAKE_CURRENT_SOURCE_DIR/Downloads" OFF)
option(DOWNLOAD_TO_BINARY_DIR "Download external dependency source archives to CMAKE_CURRENT_BINARY_DIR/Downloads" ON)
include(download_dir)

# Set up a few default arguments for all projects, such as the install prefix,
# CMake prefix path and the runtime/library output directories.
option(BUILD_SHARED_LIBS "Build libraries as SHARED" ON)

set(OpenChemistry_INSTALL_PREFIX "${OpenChemistry_BINARY_DIR}/prefix")
set(OpenChemistry_DEFAULT_ARGS
  "-DBUILD_SHARED_LIBS:BOOL=${BUILD_SHARED_LIBS}"
  "-DCMAKE_PREFIX_PATH:PATH=${OpenChemistry_INSTALL_PREFIX};${CMAKE_PREFIX_PATH}"
  "-DCMAKE_INSTALL_PREFIX:PATH=${OpenChemistry_INSTALL_PREFIX}")

# If there is a CMAKE_BUILD_TYPE it is important to ensure it is passed down.
if(CMAKE_BUILD_TYPE)
  list(APPEND OpenChemistry_DEFAULT_ARGS
    "-DCMAKE_BUILD_TYPE:STRING=${CMAKE_BUILD_TYPE}")
endif()

set(FORCE_STEP_DEFAULT "build")
if(CMAKE_CONFIGURATION_TYPES)
  set(FORCE_STEP_DEFAULT "configure")
endif()

set(FORCE_STEP ${FORCE_STEP_DEFAULT} CACHE STRING
  "Should the top level projects force configure/build/install each make")
set_property(CACHE FORCE_STEP PROPERTY STRINGS OFF configure build install)

if(FORCE_STEP STREQUAL configure)
  set(dependee "update")
elseif(FORCE_STEP STREQUAL build)
  set(dependee "configure")
elseif(FORCE_STEP STREQUAL install)
  set(dependee "build")
endif()

set(FORCE_STEP_ARGS
  DEPENDEES ${dependee}
  DEPENDERS ${FORCE_STEP}
)

# Convenience macro for adding dependencies optionally if not using system
# copies. This function takes the external project target name, looks for a
# variable of the form USE_SYSTEM_TARGETNAME, if this does not exist or is set
# to false the supplied taget name will be added to dep_var.
macro(add_optional_deps dep_var)
  foreach(_dependency ${ARGN})
    string(TOUPPER "${_dependency}" _uDependency)
    if(NOT USE_SYSTEM_${_uDependency})
      list(APPEND ${dep_var} ${_dependency})
    endif()
  endforeach()
endmacro()

# First the third party applications, some of which use Qt.
set(QT_VERSION "5" CACHE STRING "What major version of Qt")
set(QT_VERSIONS_SUPPORTED 5 6)
set_property(CACHE QT_VERSION PROPERTY STRINGS 5 6)
if(NOT QT_VERSION IN_LIST QT_VERSIONS_SUPPORTED)
  message(FATAL_ERROR "Qt version must be one of ${QT_VERSIONS_SUPPORTED}")
else()
  list(APPEND OpenChemistry_DEFAULT_ARGS "-DQT_VERSION:STRING=${QT_VERSION}")
endif()
if(QT_VERSION EQUAL 5)
  find_package(Qt5 COMPONENTS Widgets REQUIRED)
  list(APPEND OpenChemistry_DEFAULT_ARGS "-DQt5_DIR:PATH=${Qt5_DIR}")
  # Used in testing, preserve previous behavior for Qt 5 for now.
  set(BUILD_MOLEQUEUE_DEFAULT ON)
else()
  find_package(Qt6 COMPONENTS Widgets REQUIRED)
  list(APPEND OpenChemistry_DEFAULT_ARGS "-DQt6_DIR:PATH=${Qt6_DIR}")
  # MoleQueue would need some work if we were to port it.
  set(BUILD_MOLEQUEUE_DEFAULT OFF)
endif()

option(BUILD_MOLEQUEUE "Build the MoleQueue application" ${BUILD_MOLEQUEUE_DEFAULT})
option(BUILD_MOLEQUEUE_UIT "Built the UIT/ezHPC integration for MoleQueue" OFF)
option(BUILD_AVOGADRO "Build the Avogadro 2 application" ON)

# The GPL plugins just means the qtaim plugin right now, we should remove the
# GPL code, but until that happens pass down the option.
option(BUILD_GPL_PLUGINS "Build GPL plugins, i.e. QTAIM in Avogadro" OFF)

# Add the third party dependencies first
option(USE_VTK "Enable libraries that use VTK in Avogadro" OFF)
option(USE_PLOTTER "Enable functionality that uses JKQtPlotter" ON)
option(USE_HDF5 "Enable functionality that requires HDF5" OFF)
option(USE_PYTHON "Enable functionality that requires Python" OFF)
option(USE_YAEHMOP "Enable functionality that requires Yaehmop" OFF)

if(QT_VERSION EQUAL 6 AND BUILD_MOLEQUEUE)
  message("Disabling BUILD_MOLEQUEUE - it is not ported to Qt 6.")
  set(BUILD_MOLEQUEUE OFF CACHE BOOL "Build the MoleQueue application" FORCE)
endif()

# 3DConnexion devices are supported on Windows and MacOS only
if(WIN32 OR APPLE)
  option(USE_3DCONNEXION "Enable support for the 3DConnexion devices" ON)
endif()

if(USE_PYTHON)
  find_package(PythonInterp 3 REQUIRED)
  find_package(PythonLibs 3 REQUIRED)
  list(APPEND OpenChemistry_DEFAULT_ARGS
    "-DPYTHON_EXECUTABLE:FILEPATH=${PYTHON_EXECUTABLE}"
    "-DPYTHON_INCLUDE_DIR:PATH=${PYTHON_INCLUDE_DIR}"
    "-DPYTHON_LIBRARY:FILEPATH=${PYTHON_LIBRARY}")
endif()

add_subdirectory(thirdparty)

option(BUILD_DOCUMENTATION "Build documentation (Doxygen)" OFF)
option(ENABLE_TESTING "Enable testing for Open Chemistry projects" OFF)
list(APPEND OpenChemistry_DEFAULT_ARGS
  "-DBUILD_DOCUMENTATION:BOOL=${BUILD_DOCUMENTATION}"
  "-DENABLE_TESTING:BOOL=${ENABLE_TESTING}"
  "-DUSE_PYTHON:BOOL=${USE_PYTHON}"
  "-DUSE_VTK:BOOL=${USE_VTK}")

if(WIN32 OR APPLE)
  list(APPEND OpenChemistry_DEFAULT_ARGS
    "-DUSE_3DCONNEXION:BOOL=${USE_3DCONNEXION}")
endif()  


# Now for the actual open chemistry projects!
if(BUILD_MOLEQUEUE)
  include(External_molequeue)
endif()
if(BUILD_AVOGADRO)
  include(External_avogadrolibs)
  include(External_avogadroapp)
endif()
