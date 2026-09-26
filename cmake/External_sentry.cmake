# An external project for sentry-native (crash reporting)
#
# Note: this uses the *release asset* rather than the /archive/ tarball that
# most projects here use. Only the release asset vendors crashpad; the archive
# tarball expects git submodules to be initialized.
set(sentry_source "${CMAKE_CURRENT_BINARY_DIR}/sentry-src")
set(sentry_install "${OpenChemistry_INSTALL_PREFIX}")

get_filename_component(_self_dir ${CMAKE_CURRENT_LIST_FILE} PATH)

ExternalProject_Add(sentry
  DOWNLOAD_DIR ${download_dir}
  SOURCE_DIR "${sentry_source}"
  INSTALL_DIR "${sentry_install}"
  URL ${sentry_url}
  URL_HASH SHA256=${sentry_sha256}
  CMAKE_CACHE_ARGS
    ${OpenChemistry_DEFAULT_ARGS}
  CMAKE_ARGS
    -DCMAKE_INSTALL_PREFIX:PATH=<INSTALL_DIR>
    # Out-of-process handler, so we still get a report when the heap or the
    # stack is too damaged for an in-process handler to run.
    -DSENTRY_BACKEND:STRING=crashpad
    # WinHTTP avoids pulling in curl/OpenSSL just for the uploader.
    -DSENTRY_TRANSPORT:STRING=winhttp
    # Turns Qt log messages into breadcrumbs. Chains to any handler installed
    # before sentry_init(), so ordering in main() matters - see crashreporter.
    -DSENTRY_INTEGRATION_QT:BOOL=ON
    -DSENTRY_BUILD_SHARED_LIBS:BOOL=ON
    -DSENTRY_BUILD_TESTS:BOOL=OFF
    -DSENTRY_BUILD_EXAMPLES:BOOL=OFF
)

# The crashpad binaries land in the shared prefix, not in this project's own
# ExternalProject prefix: OpenChemistry_DEFAULT_ARGS carries CMAKE_INSTALL_PREFIX
# through CMAKE_CACHE_ARGS, which ExternalProject writes with FORCE and so wins
# over CMAKE_ARGS. INSTALL_DIR above is set to match, so <INSTALL_DIR> and the
# effective prefix agree rather than silently disagreeing.
#
# sentry-native forces CRASHPAD_ENABLE_INSTALL off when building a shared
# library, so the crashpad binaries reach the install prefix through crashpad's
# own unguarded install() rules. That is easy to break on an upgrade, and the
# failure is silent - the app starts fine and simply never reports a crash.
# Check for them here so it fails loudly at build time instead.
if(WIN32)
  set(_sentry_expect_wer ON)
else()
  set(_sentry_expect_wer OFF)
endif()

ExternalProject_Add_Step(sentry verify-install
  COMMAND ${CMAKE_COMMAND}
    -DSENTRY_BIN_DIR=${sentry_install}/bin
    # Passed in because a `cmake -P` script has no project context, so it has
    # no CMAKE_EXECUTABLE_SUFFIX of its own.
    -DSENTRY_EXE_SUFFIX=${CMAKE_EXECUTABLE_SUFFIX}
    -DSENTRY_EXPECT_WER=${_sentry_expect_wer}
    -P "${_self_dir}/verify_sentry_install.cmake"
  COMMENT "Verifying the sentry-native crash handler binaries were installed"
  DEPENDEES install
  ALWAYS 0
)
