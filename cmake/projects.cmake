unset(projects)

# The base URL for all hosted files to use when downloading
if(DEFINED OpenChemistry_DOWNLOAD_BASE_URL)
  set(oc_download_base ${OpenChemistry_DOWNLOAD_BASE_URL})
else()
  set(oc_download_base "http://www.openchemistry.org/files")
endif()

# Eigen
list(APPEND projects eigen)
set(eigen_version "3.3.7")
set(eigen_url "http://bitbucket.org/eigen/eigen/get/${eigen_version}.tar.gz")
set(eigen_md5 "f2a417d083fe8ca4b8ed2bc613d20f07")

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
set(openbabel_version "3.0.0")
set(openbabel_url "https://github.com/openbabel/openbabel/archive/openbabel-openbabel-3-0-0.tar.gz")
set(openbabel_md5 "4c0ba0ce5dac240b51dded72f69edbc0")

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
set(msgpackc_version "3.2.0")
set(msgpackc_url "https://github.com/msgpack/msgpack-c/releases/download/cpp-${msgpackc_version}/msgpack-${msgpackc_version}.tar.gz")
set(msgpackc_md5 "53ae37b760690562a1e1cc03d5e1baa4")

# mmtf-cpp
list(APPEND projects mmtf-cpp)
set(mmtfcpp_version "1.0.0")
set(mmtfcpp_url "https://github.com/rcsb/mmtf-cpp/archive/v${mmtfcpp_version}.tar.gz")
set(mmtfcpp_md5 "553f028a771b9d9f824903a2bf34be51")
