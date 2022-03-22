unset(projects)

# The base URL for all hosted files to use when downloading
if(DEFINED OpenChemistry_DOWNLOAD_BASE_URL)
  set(oc_download_base ${OpenChemistry_DOWNLOAD_BASE_URL})
else()
  set(oc_download_base "http://www.openchemistry.org/files")
endif()

# Eigen
list(APPEND projects eigen)
set(eigen_version "3.4.0")
set(eigen_url "https://gitlab.com/libeigen/eigen/-/archive/${eigen_version}/eigen-${eigen_version}.tar.gz")
set(eigen_md5 "4c527a9171d71a72a9d4186e65bea559")

# glew
list(APPEND projects glew)
set(glew_version "2.2.0")
set(glew_url "https://github.com/nigels-com/glew/releases/download/glew-${glew_version}/glew-${glew_version}.tgz")
set(glew_md5 "3579164bccaef09e36c0af7f4fd5c7c7")

# gtest
list(APPEND projects gtest)
set(gtest_version "1.7.0")
set(gtest_url "https://github.com/google/googletest/archive/release-${gtest_version}.tar.gz")
set(gtest_md5 "4ff6353b2560df0afecfbda3b2763847")

# hdf5
list(APPEND projects hdf5)
set(hdf5_version "1_10_7")
set(hdf5_url "https://github.com/HDFGroup/hdf5/archive/hdf5-${hdf5_version}.tar.gz")
set(hdf5_md5 "be1b6012fb48ded5a2df3705f9cd6958")

# Open Babel
list(APPEND projects openbabel)
set(openbabel_version "3-1-1")
set(openbabel_url "https://github.com/openbabel/openbabel/archive/openbabel-${openbabel_version}.tar.gz")
set(openbabel_md5 "7efb864d2ba5593b286ddc49d70aa851")

# PCRE
list(APPEND projects pcre)
set(pcre_version "8.45")
set(pcre_url "https://sourceforge.net/projects/pcre/files/pcre/${pcre_version}/pcre-${pcre_version}.tar.gz/download")
set(pcre_md5 "3bcd2441024d00009a5fee43f058987c")

# libxml2
list(APPEND projects libxml2)
set(libxml2_version "2.9.13")
set(libxml2_url "https://gitlab.gnome.org/GNOME/libxml2/-/archive/v${libxml2_version}/libxml2-v${libxml2_version}.tar.gz")
set(libxml2_md5 "99dbd55a77c09edeeaaef5412e98769b")

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
set(spglib_version "1.16.3")
set(spglib_url "https://github.com/atztogo/spglib/archive/v${spglib_version}.tar.gz")
set(spglib_md5 "ebbb94f9925df098cc689f0e5b5d93e4")

# libarchive
list(APPEND projects libarchive)
set(libarchive_version "3.6.0")
set(libarchive_url "https://github.com/libarchive/libarchive/archive/v${libarchive_version}.tar.gz")
set(libarchive_md5 "c6aee4307af87c04d327e6fbbee680a0")

# msgpackc
list(APPEND projects msgpackc)
set(msgpackc_version "3.3.0")
set(msgpackc_url "https://github.com/msgpack/msgpack-c/releases/download/cpp-${msgpackc_version}/msgpack-${msgpackc_version}.tar.gz")
set(msgpackc_md5 "e676575d52caae974e579c3d5f0ba6a2")

# mmtf-cpp
list(APPEND projects mmtf-cpp)
set(mmtfcpp_version "1.0.0")
set(mmtfcpp_url "https://github.com/rcsb/mmtf-cpp/archive/v${mmtfcpp_version}.tar.gz")
set(mmtfcpp_md5 "553f028a771b9d9f824903a2bf34be51")
