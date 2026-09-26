# Verify that sentry-native installed the crash handler binaries.
#
# The crashpad backend is useless without crashpad_handler, and fast-fail /
# stack-buffer-overrun crashes are missed without crashpad_wer.dll next to it.
# Neither omission produces any error at runtime, so check at build time.
#
# Run via `cmake -P`, which means there is no project context here: the caller
# passes in SENTRY_BIN_DIR, SENTRY_EXE_SUFFIX and SENTRY_EXPECT_WER rather than
# this script deriving them, because CMAKE_EXECUTABLE_SUFFIX is not set in
# script mode.

set(_required "${SENTRY_BIN_DIR}/crashpad_handler${SENTRY_EXE_SUFFIX}")
if(SENTRY_EXPECT_WER)
  list(APPEND _required "${SENTRY_BIN_DIR}/crashpad_wer.dll")
endif()

set(_missing "")
foreach(_file ${_required})
  if(NOT EXISTS "${_file}")
    list(APPEND _missing "${_file}")
  endif()
endforeach()

if(_missing)
  string(REPLACE ";" "\n  " _missing_list "${_missing}")
  message(FATAL_ERROR
    "sentry-native did not install its crash handler binaries:\n"
    "  ${_missing_list}\n"
    "Crash reporting would silently do nothing. Check whether the "
    "sentry-native install rules changed in this version.")
endif()

message(STATUS "sentry-native crash handler binaries verified in ${SENTRY_BIN_DIR}")
