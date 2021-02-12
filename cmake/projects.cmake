unset(projects)

# The base URL for all hosted files to use when downloading
if(DEFINED OpenChemistry_DOWNLOAD_BASE_URL)
  set(oc_download_base ${OpenChemistry_DOWNLOAD_BASE_URL})
else()
  set(oc_download_base "http://www.openchemistry.org/files")
endif()

# Eigen
list(APPEND projects eigen)
set(eigen_version "3.3.9")
set(eigen_url "https://gitlab.com/libeigen/eigen/-/archive/${eigen_version}/eigen-${eigen_version}.tar.gz")
set(eigen_md5 "609286804b0f79be622ccf7f9ff2b660")

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

# hdf5
list(APPEND projects hdf5)
set(hdf5_version "1_10_6")
set(hdf5_url "https://github.com/HDFGroup/hdf5/archive/hdf5-${hdf5_version}.tar.gz")
set(hdf5_md5 "abbf353b2d8a1d5a062bdbba1c365171")

# Open Babel
list(APPEND projects openbabel)
set(openbabel_version "3-1-1")
set(openbabel_url "https://github.com/openbabel/openbabel/archive/openbabel-${openbabel_version}.tar.gz")
set(openbabel_md5 "7efb864d2ba5593b286ddc49d70aa851")

# PCRE
list(APPEND projects pcre)
set(pcre_version "8.44")
set(pcre_url "https://sourceforge.net/projects/pcre/files/pcre/${pcre_version}/pcre-${pcre_version}.tar.gz/download")
set(pcre_md5 "3bcd2441024d00009a5fee43f058987c")

# libxml2
list(APPEND projects libxml2)
set(libxml2_version "2.9.8")
set(libxml2_url "https://gitlab.gnome.org/GNOME/libxml2/-/archive/v2.9.10/libxml2-v${libxml2_version}.tar.gz")
set(libxml2_md5 "b786e353e2aa1b872d70d5d1ca0c740d")

# Zlib
list(APPEND projects zlib)
set(zlib_version "1.2.11")
set(zlib_url "https://github.com/madler/zlib/archive/v${zlib_version}.tar.gz")
set(zlib_md5 "0095d2d2d1f3442ce1318336637b695f")

# KDSoap
list(APPEND projects kdsoap)
set(kdsoap_version "1.10.0")
set(kdsoap_url "https://github.com/KDAB/KDSoap/releases/download/kdsoap-${kdsoap_version}/kdsoap-${kdsoap_version}.tar.gz")
set(kdsoap_md5 "ac6fa410678873c634c4fe0db875c02a")

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
set(msgpackc_version "3.2.1")
set(msgpackc_url "https://github.com/msgpack/msgpack-c/releases/download/cpp-${msgpackc_version}/msgpack-${msgpackc_version}.tar.gz")
set(msgpackc_md5 "ef10c80885c4f5e4baf8d37113629eae")

# mmtf-cpp
list(APPEND projects mmtf-cpp)
set(mmtfcpp_version "1.0.0")
set(mmtfcpp_url "https://github.com/rcsb/mmtf-cpp/archive/v${mmtfcpp_version}.tar.gz")
set(mmtfcpp_md5 "553f028a771b9d9f824903a2bf34be51")
