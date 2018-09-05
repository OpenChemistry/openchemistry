unset(projects)

# The base URL for all hosted files to use when downloading
if(DEFINED OpenChemistry_DOWNLOAD_BASE_URL)
  set(oc_download_base ${OpenChemistry_DOWNLOAD_BASE_URL})
else()
  set(oc_download_base "http://www.openchemistry.org/files")
endif()

# Eigen
list(APPEND projects eigen)
set(eigen_version "3.3.4")
set(eigen_url "${oc_download_base}/tpl/eigen-${eigen_version}.tar.gz")
set(eigen_md5 "090d992044f873890211d6410f580fd1")

# glew
list(APPEND projects glew)
set(glew_version "2.1.0")
set(glew_url "https://sourceforge.net/projects/glew/files/glew/${glew_version}/glew-${glew_version}.tgz/download")
set(glew_md5 "b2ab12331033ddfaa50dc39345343980")

# gtest
list(APPEND projects gtest)
set(gtest_version "1.7.0")
set(gtest_url "https://github.com/google/googletest/archive/release-${gtest_version}.tar.gz")
set(gtest_md5 "4ff6353b2560df0afecfbda3b2763847")
#set(gtest_md5 "16877098823401d1bf2ed7891d7dce36")

# hdf5
list(APPEND projects hdf5)
set(hdf5_version "1.10.1")
set(hdf5_url "${oc_download_base}/tpl/hdf5-${hdf5_version}.tar.gz")
set(hdf5_md5 "43a2f9466702fb1db31df98ae6677f15")

# Open Babel
list(APPEND projects openbabel)
set(openbabel_version "2.4.1")
set(openbabel_url "http://sourceforge.net/projects/openbabel/files/openbabel/${openbabel_version}/openbabel-${openbabel_version}.tar.gz/download")
#set(openbabel_url "${oc_download_base}/tpl/openbabel-${openbabel_version}.tar.gz")
set(openbabel_md5 "d9defcd7830b0592fece4fe54a137b99")

# PCRE
list(APPEND projects pcre)
set(pcre_version "8.34")
set(pcre_url "${oc_download_base}/tpl/pcre-${pcre_version}.tar.gz")
set(pcre_md5 "eb34b2c9c727fd64940d6fd9a00995eb")

# libxml2
list(APPEND projects libxml2)
set(libxml2_version "2.9.8")
set(libxml2_url "${oc_download_base}/tpl/libxml2-${libxml2_version}.tar.gz")
set(libxml2_md5 "b786e353e2aa1b872d70d5d1ca0c740d")

# Zlib
list(APPEND projects zlib)
set(zlib_version "1.2.11")
set(zlib_url "${oc_download_base}/tpl/zlib-${zlib_version}.tar.gz")
set(zlib_md5 "1c9f62f0778697a09d36121ead88e08e")

# KDSoap
list(APPEND projects kdsoap)
set(kdsoap_version "1.5.1-fb44069")
#set(kdsoap_url "https://github.com/KDAB/KDSoap/releases/download/kdsoap-${kdsoap_version}/kdsoap-${kdsoap_version}.tar.gz")
set(kdsoap_url "${oc_download_base}/tpl/kdsoap-${kdsoap_version}.tar.gz")
set(kdsoap_md5 "f9df9bf9bb3378da10f987f3f3dbcd57")

# spglib
list(APPEND projects spglib)
set(spglib_version "1.10.4")
set(spglib_url "https://github.com/atztogo/spglib/archive/v${spglib_version}.tar.gz")
set(spglib_md5 "df49ddccecfe82e50ade640d6547571b")

# libarchive
list(APPEND projects libarchive)
set(libarchive_version "3.3.2")
set(libarchive_url "https://github.com/libarchive/libarchive/archive/v${libarchive_version}.tar.gz")
set(libarchive_md5 "a3acebe237f89d7f31c5bb1da5e843c7")

# msgpackc
list(APPEND projects msgpackc)
set(msgpackc_version "3.1.0")
set(msgpackc_url "https://github.com/msgpack/msgpack-c/releases/download/cpp-${msgpackc_version}/msgpack-3.1.0.tar.gz")
set(msgpackc_md5 "57bdba5ae83831c7c04aad39e479b225")

# mmtf-cpp
list(APPEND projects mmtf-cpp)
set(mmtfcpp_version "63e58a9057ee684b5a0a409932e7fc2126894fc0")
set(mmtfcpp_url "https://github.com/rcsb/mmtf-cpp/archive/${mmtfcpp_version}.tar.gz")
set(mmtfcpp_md5 "331c5c9c878f650381bcbdeac06dcfbe")

# yaehmop binary
set(YAEHMOP_V "3.0.3")
# Linux
list(APPEND projects yaehmop)
if(UNIX AND NOT APPLE)
  set(yaehmop_binary_url "https://github.com/psavery/yaehmop/releases/download/${YAEHMOP_V}/linux64-yaehmop.tgz")
  set(yaehmop_binary_md5 "7f3f71c076d8604b98a7e60c351febf2")
# Apple
elseif(APPLE)
  set(yaehmop_binary_url "https://github.com/psavery/yaehmop/releases/download/${YAEHMOP_V}/mac64-yaehmop.tgz")
  set(yaehmop_binary_md5 "465b8217f5aed9244513dbc00f083133")
# Windows
elseif(WIN32)
  set(yaehmop_binary_url "https://github.com/psavery/yaehmop/releases/download/${YAEHMOP_V}/win32-yaehmop.exe.tgz")
  set(yaehmop_binary_md5 "89be7c295200f39f5c3b2c99d14ecb1e")
else()
  message(FATAL_ERROR
          "Yaehmop is not supported with the current OS type!")
endif()
