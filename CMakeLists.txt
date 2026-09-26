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
# Subprocess execution is distinct from Python API bindings (USE_PYTHON).
set(_subprocess_default ON)
set(_web_default OFF)
if(EMSCRIPTEN)
  set(_subprocess_default OFF)
  set(_web_default ON)
endif()
option(ENABLE_SUBPROCESS "Enable external processes and Python script plugins" ${_subprocess_default})
option(AVOGADRO_WEB_EDITOR "Build the minimal web editor profile" ${_web_default})
set(_desktop_features_default ON)
if(AVOGADRO_WEB_EDITOR OR NOT ENABLE_SUBPROCESS)
  set(_desktop_features_default OFF)
endif()

set(_shared_default ON)
if(EMSCRIPTEN)
  set(_shared_default OFF)
endif()
option(BUILD_SHARED_LIBS "Build libraries as SHARED" ${_shared_default})
if(EMSCRIPTEN)
  if(BUILD_SHARED_LIBS)
    message(FATAL_ERROR "WASM requires BUILD_SHARED_LIBS=OFF")
  endif()
endif()

set(OpenChemistry_INSTALL_PREFIX "${OpenChemistry_BINARY_DIR}/prefix")
set(OpenChemistry_DEFAULT_ARGS
  "-DBUILD_SHARED_LIBS:BOOL=${BUILD_SHARED_LIBS}"
  "-DCMAKE_PREFIX_PATH:PATH=${OpenChemistry_INSTALL_PREFIX};${CMAKE_PREFIX_PATH}"
  "-DCMAKE_INSTALL_PREFIX:PATH=${OpenChemistry_INSTALL_PREFIX}")

if(CMAKE_FIND_ROOT_PATH)
  list(APPEND OpenChemistry_DEFAULT_ARGS
    "-DCMAKE_FIND_ROOT_PATH:PATH=${OpenChemistry_INSTALL_PREFIX};${CMAKE_FIND_ROOT_PATH}")
else()
  list(APPEND OpenChemistry_DEFAULT_ARGS
    "-DCMAKE_FIND_ROOT_PATH:PATH=${OpenChemistry_INSTALL_PREFIX}")
endif()

# Explicit archive hints are only needed by the static cross-compilation build.
if(EMSCRIPTEN)
  set(OpenChemistry_THIRDPARTYLIBS_ARGS
    "-DEigen3_DIR:PATH=${OpenChemistry_INSTALL_PREFIX}/share/eigen3/cmake"
    "-DSpglib_DIR:PATH=${OpenChemistry_INSTALL_PREFIX}/lib/cmake/Spglib"
    "-DLIBMSYM_INCLUDE_DIR:PATH=${OpenChemistry_INSTALL_PREFIX}/include"
    "-DLIBMSYM_LIBRARY:FILEPATH=${OpenChemistry_INSTALL_PREFIX}/lib/libmsym.a"
    "-DGLEW_INCLUDE_DIR:PATH=${OpenChemistry_INSTALL_PREFIX}/include"
    "-DGLEW_USE_STATIC_LIBS:BOOL=ON"
    "-DGLEW_LIBRARY:FILEPATH=${OpenChemistry_INSTALL_PREFIX}/lib/libGLEW.a"
    "-DGLEW_LIBRARIES:FILEPATH=${OpenChemistry_INSTALL_PREFIX}/lib/libGLEW.a"
    "-DGLEW_STATIC_LIBRARY_RELEASE:FILEPATH=${OpenChemistry_INSTALL_PREFIX}/lib/libGLEW.a")
endif()

foreach(_var
    CMAKE_TOOLCHAIN_FILE
    CMAKE_SYSROOT
    QT_HOST_PATH
    QT_HOST_PATH_CMAKE_DIR)
  if(DEFINED ${_var})
    list(APPEND OpenChemistry_DEFAULT_ARGS "-D${_var}:PATH=${${_var}}")
  endif()
endforeach()

if(CMAKE_CROSSCOMPILING)
  list(APPEND OpenChemistry_DEFAULT_ARGS
    "-DCMAKE_SYSTEM_NAME:STRING=${CMAKE_SYSTEM_NAME}")
endif()

if(EMSCRIPTEN AND DEFINED ENV{EMSDK})
  set(_openchemistry_emscripten_toolchain
    "$ENV{EMSDK}/upstream/emscripten/cmake/Modules/Platform/Emscripten.cmake")
  if(EXISTS "${_openchemistry_emscripten_toolchain}")
    list(APPEND OpenChemistry_DEFAULT_ARGS
      "-DQT_CHAINLOAD_TOOLCHAIN_FILE:FILEPATH=${_openchemistry_emscripten_toolchain}")
  endif()
  list(APPEND OpenChemistry_DEFAULT_ARGS
    "-DCMAKE_C_FLAGS:STRING=-pthread"
    "-DCMAKE_CXX_FLAGS:STRING=-pthread"
    "-DCMAKE_EXE_LINKER_FLAGS:STRING=-pthread")
  unset(_openchemistry_emscripten_toolchain)
endif()

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
set(QT_VERSION "6" CACHE STRING "What major version of Qt")
set(QT_VERSIONS_SUPPORTED 6)
set_property(CACHE QT_VERSION PROPERTY STRINGS 6)
if(NOT QT_VERSION IN_LIST QT_VERSIONS_SUPPORTED)
  message(FATAL_ERROR "Qt version must be one of ${QT_VERSIONS_SUPPORTED}")
else()
  list(APPEND OpenChemistry_DEFAULT_ARGS "-DQT_VERSION:STRING=${QT_VERSION}")
endif()
find_package(Qt6 COMPONENTS Widgets REQUIRED)
get_filename_component(_qt_prefix "${Qt6_DIR}/../../.." ABSOLUTE)
list(APPEND OpenChemistry_DEFAULT_ARGS
  "-DQt6_DIR:PATH=${Qt6_DIR}"
  "-DQT_DIR:PATH=${Qt6_DIR}"
  "-DCMAKE_PREFIX_PATH:PATH=${OpenChemistry_INSTALL_PREFIX};${_qt_prefix};${CMAKE_PREFIX_PATH}")
# MoleQueue would need some work if we were to port it.
set(BUILD_MOLEQUEUE_DEFAULT OFF)

option(BUILD_MOLEQUEUE "Build the MoleQueue application" ${BUILD_MOLEQUEUE_DEFAULT})
option(BUILD_MOLEQUEUE_UIT "Built the UIT/ezHPC integration for MoleQueue" OFF)
option(BUILD_AVOGADRO "Build the Avogadro 2 application" ON)

# The GPL plugins just means the qtaim plugin right now, we should remove the
# GPL code, but until that happens pass down the option.
option(BUILD_GPL_PLUGINS "Build GPL plugins, i.e. QTAIM in Avogadro" OFF)
option(BUILD_STATIC_PLUGINS "Build Avogadro plugins statically" ON)

# Add the third party dependencies first
option(USE_PLOTTER "Enable functionality that uses JKQtPlotter" ${_desktop_features_default})
option(USE_HDF5 "Enable functionality that requires HDF5" OFF)
option(USE_PYTHON "Enable functionality that requires Python" OFF)
option(USE_YAEHMOP "Enable functionality that requires Yaehmop" OFF)
option(USE_OPENGL "Enable functionality that requires OpenGL" ON)
option(USE_LIBARCHIVE "Enable optional Libarchive features" ${_desktop_features_default})
option(USE_LIBMSYM "Enable optional features using libmsym" ON)
option(USE_SPGLIB "Enable optional features using spglib" ON)

if(EMSCRIPTEN AND (ENABLE_SUBPROCESS OR USE_LIBARCHIVE OR USE_PYTHON))
  message(FATAL_ERROR "WASM requires ENABLE_SUBPROCESS=OFF, USE_LIBARCHIVE=OFF and USE_PYTHON=OFF. Configure a fresh build directory with these options.")
endif()
if(EMSCRIPTEN AND NOT AVOGADRO_WEB_EDITOR)
  message(FATAL_ERROR "WASM builds require AVOGADRO_WEB_EDITOR=ON; the desktop application is native-only")
endif()
if(AVOGADRO_WEB_EDITOR AND NOT BUILD_STATIC_PLUGINS)
  message(FATAL_ERROR "AVOGADRO_WEB_EDITOR requires BUILD_STATIC_PLUGINS=ON")
endif()
if(AVOGADRO_WEB_EDITOR AND (ENABLE_SUBPROCESS OR USE_LIBARCHIVE OR USE_PLOTTER))
  message(FATAL_ERROR "AVOGADRO_WEB_EDITOR requires ENABLE_SUBPROCESS=OFF, USE_LIBARCHIVE=OFF and USE_PLOTTER=OFF.")
endif()

if(AVOGADRO_WEB_EDITOR AND NOT USE_OPENGL)
  message(FATAL_ERROR "AVOGADRO_WEB_EDITOR requires USE_OPENGL=ON for its viewport")
endif()

if(NOT ENABLE_SUBPROCESS AND BUILD_MOLEQUEUE)
  message(FATAL_ERROR "BUILD_MOLEQUEUE requires ENABLE_SUBPROCESS=ON")
endif()

if(QT_VERSION EQUAL 6 AND BUILD_MOLEQUEUE)
  message("Disabling BUILD_MOLEQUEUE - it is not ported to Qt 6.")
  set(BUILD_MOLEQUEUE OFF CACHE BOOL "Build the MoleQueue application" FORCE)
endif()

# 3DConnexion devices are supported on Windows and MacOS only
# but need to be updated for OpenGL 4.0 Core Profile
if(WIN32 OR APPLE)
  option(USE_3DCONNEXION "Enable support for the 3DConnexion devices" OFF)
endif()

# Crash reporting via sentry-native. This is off by default and only enabled
# for the separate Windows diagnostic build, which ships its own installer.
if(WIN32)
  option(USE_SENTRY "Enable Sentry crash reporting (diagnostic builds)" OFF)
  set(SENTRY_DSN "" CACHE STRING "Sentry DSN for crash reports")
  set(SENTRY_ENVIRONMENT "nightly" CACHE STRING
    "Sentry environment name reported with each event")
elseif(USE_SENTRY)
  message("Disabling USE_SENTRY - it is only supported on Windows.")
  set(USE_SENTRY OFF CACHE BOOL
    "Enable Sentry crash reporting (diagnostic builds)" FORCE)
endif()

if(USE_PYTHON)
  find_package(PythonInterp 3 REQUIRED)
  find_package(PythonLibs 3 REQUIRED)
  list(APPEND OpenChemistry_DEFAULT_ARGS
    "-DPYTHON_EXECUTABLE:FILEPATH=${PYTHON_EXECUTABLE}"
    "-DPYTHON_INCLUDE_DIR:PATH=${PYTHON_INCLUDE_DIR}"
    "-DPYTHON_LIBRARY:FILEPATH=${PYTHON_LIBRARY}")
endif()

#add_subdirectory(thirdparty)

option(BUILD_DOCUMENTATION "Build documentation (Doxygen)" OFF)
option(ENABLE_TESTING "Enable testing for Open Chemistry projects" OFF)
list(APPEND OpenChemistry_DEFAULT_ARGS
  "-DBUILD_DOCUMENTATION:BOOL=${BUILD_DOCUMENTATION}"
  "-DENABLE_TESTING:BOOL=${ENABLE_TESTING}"
  "-DENABLE_SUBPROCESS:BOOL=${ENABLE_SUBPROCESS}"
  "-DAVOGADRO_WEB_EDITOR:BOOL=${AVOGADRO_WEB_EDITOR}"
  "-DBUILD_STATIC_PLUGINS:BOOL=${BUILD_STATIC_PLUGINS}"
  "-DUSE_PYTHON:BOOL=${USE_PYTHON}"
  "-DUSE_OPENGL:BOOL=${USE_OPENGL}"
  "-DUSE_LIBARCHIVE:BOOL=${USE_LIBARCHIVE}"
  "-DUSE_LIBMSYM:BOOL=${USE_LIBMSYM}"
  "-DUSE_SPGLIB:BOOL=${USE_SPGLIB}")

if(WIN32 OR APPLE)
  list(APPEND OpenChemistry_DEFAULT_ARGS
    "-DUSE_3DCONNEXION:BOOL=${USE_3DCONNEXION}")
endif()  

add_optional_deps(OpenChemistry_external_deps "eigen")

if(USE_SPGLIB)
  add_optional_deps(OpenChemistry_external_deps "spglib")
endif()

if(USE_OPENGL)
  add_optional_deps(OpenChemistry_external_deps "glew")
endif()

if(USE_LIBMSYM)
  add_optional_deps(OpenChemistry_external_deps "libmsym")
endif()

if(USE_LIBARCHIVE)
  add_optional_deps(OpenChemistry_external_deps "libarchive")
endif()

if(USE_PLOTTER)
  add_optional_deps(OpenChemistry_external_deps "jkqtplotter")
endif()

if(USE_PYTHON)
  add_optional_deps(OpenChemistry_external_deps "pybind11")
endif()

if(USE_HDF5)
  add_optional_deps(OpenChemistry_external_deps "hdf5")
endif()

if(ENABLE_TESTING)
  add_optional_deps(OpenChemistry_external_deps "gtest")
  if(NOT AVOGADRO_WEB_EDITOR)
    add_optional_deps(OpenChemistry_external_deps "qttesting")
  endif()
endif()

foreach(_dependency IN LISTS OpenChemistry_external_deps)
  if(_dependency STREQUAL "jkqtplotter")
    include(External_JKQTPlotter)
  else()
    include(External_${_dependency})
  endif()
endforeach()

# Now for the actual open chemistry projects!
if(BUILD_MOLEQUEUE)
  include(External_molequeue)
endif()
if(BUILD_AVOGADRO)
  include(External_avogadrolibs)
  include(External_avogadroapp)
endif()
