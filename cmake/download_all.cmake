# This script downloads all of the project source tarballs.

get_filename_component(_self_dir ${CMAKE_CURRENT_LIST_FILE} PATH)
include("${_self_dir}/projects.cmake")
include("${_self_dir}/download_dir.cmake")


function(compute_filename_from_url url filename_var)
  string(REGEX MATCH "[^/\\?]*$" fname "${url}")
  if(NOT "${fname}" MATCHES "(\\.|=)(bz2|tar|tgz|tar\\.gz|zip)$")
    string(REGEX MATCH "([^/\\?]+(\\.|=)(bz2|tar|tgz|tar\\.gz|zip))/.*$" match_result "${url}")
    set(fname "${CMAKE_MATCH_1}")
  endif()
  if(NOT "${fname}" MATCHES "(\\.|=)(bz2|tar|tgz|tar\\.gz|zip)$")
    message(FATAL_ERROR "Could not extract tarball filename from url:\n  ${url}")
  endif()
  string(REPLACE ";" "-" fname "${fname}")
  set(${filename_var} "${fname}" PARENT_SCOPE)
endfunction()


# Download each file in turn. If it exists and the md5 matches, it will not be
# downloaded again. If the md5 differs, it will be deleted and downloaded.
message(STATUS "Downloading source tarballs to '${download_dir}'...")
foreach(proj ${projects})
  compute_filename_from_url(${${proj}_url} filename)
  message(STATUS "Downloading ${proj} source tarball '${filename}'...")
  file(DOWNLOAD
    ${${proj}_url}
    ${download_dir}/${filename}
    TIMEOUT 3600
    STATUS status
    LOG log
    EXPECTED_MD5 ${${proj}_md5}
    SHOW_PROGRESS)
  list(GET status 0 status_code)
  list(GET status 1 status_string)
  if(NOT status_code EQUAL 0)
    message(SEND_ERROR "error: downloading '${${proj}_url}' failed
  status_code: ${status_code}
  status_string: ${status_string}
  log: ${log}
")
  endif()
endforeach()
