# Rewrite Open Babel's install RPATH to be relative to $ORIGIN.
#
# Upstream sets CMAKE_INSTALL_RPATH to the absolute install prefix, which bakes
# the build machine's prefix into every binary, library and plugin. That breaks
# relocated installs such as the AppImage (plugins in lib/openbabel/ cannot find
# libinchi in lib/). Upstream uses a plain set(), so a cache argument cannot
# override it; patch the source instead. Can be dropped once Open Babel supports
# relocatable RPATHs outside BUILD_BY_PIP.
#
# Usage: cmake -DOPENBABEL_SOURCE_DIR=<dir> -P openbabel_relative_rpath.cmake

if(NOT DEFINED OPENBABEL_SOURCE_DIR)
  message(FATAL_ERROR "OPENBABEL_SOURCE_DIR must be defined")
endif()

set(_file "${OPENBABEL_SOURCE_DIR}/CMakeLists.txt")
if(NOT EXISTS "${_file}")
  message(FATAL_ERROR "Open Babel CMakeLists.txt not found: ${_file}")
endif()

set(_original [=[set(CMAKE_INSTALL_RPATH "${CMAKE_INSTALL_PREFIX}/${LIB_INSTALL_DIR}")]=])
set(_replacement [=[set(CMAKE_INSTALL_RPATH "$ORIGIN/../${LIB_INSTALL_DIR};$ORIGIN;$ORIGIN/..")]=])

file(READ "${_file}" _content)

string(FIND "${_content}" "${_replacement}" _patched)
if(NOT _patched EQUAL -1)
  message(STATUS "Open Babel RPATH already patched: ${_file}")
  return()
endif()

string(FIND "${_content}" "${_original}" _found)
if(_found EQUAL -1)
  message(FATAL_ERROR
    "Could not find the CMAKE_INSTALL_RPATH line in ${_file}. "
    "The Open Babel RPATH patch needs updating.")
endif()

string(REPLACE "${_original}" "${_replacement}" _new_content "${_content}")
if(NOT _new_content STREQUAL _content)
  file(WRITE "${_file}" "${_new_content}")
  message(STATUS "Patched Open Babel RPATH: ${_file}")
endif()
