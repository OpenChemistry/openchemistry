# This script defines a download_dir variable, if it's not already defined.

# Cache the downloads in download_dir if it's defined. Otherwise, use the
# user's typical Downloads directory, if it already exists. Otherwise, use a
# Downloads subdir in the build tree.
#
if(NOT DEFINED download_dir)
  if(NOT "$ENV{HOME}" STREQUAL "" AND EXISTS "$ENV{HOME}/Downloads")
    set(download_dir "$ENV{HOME}/Downloads")
  elseif(NOT "$ENV{USERPROFILE}" STREQUAL "" AND EXISTS "$ENV{USERPROFILE}/Downloads")
    set(download_dir "$ENV{USERPROFILE}/Downloads")
  elseif(NOT "${CMAKE_CURRENT_BINARY_DIR}" STREQUAL "")
    set(download_dir "${CMAKE_CURRENT_BINARY_DIR}/Downloads")
  else()
    message(FATAL_ERROR "unexpectedly empty CMAKE_CURRENT_BINARY_DIR")
  endif()
  string(REPLACE "\\" "/" download_dir "${download_dir}")
endif()

file(MAKE_DIRECTORY "${download_dir}")
if(NOT EXISTS "${download_dir}")
  message(FATAL_ERROR "could not find or make Downloads directory")
endif()
