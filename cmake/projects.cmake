unset(projects)

# Eigen
list(APPEND projects eigen)
set(eigen_version "3.4.0")
set(eigen_url "https://gitlab.com/libeigen/eigen/-/archive/${eigen_version}/eigen-${eigen_version}.tar.gz")
set(eigen_sha256 "8586084f71f9bde545ee7fa6d00288b264a2b7ac3607b974e54d13e7162c1c72")

# glew
list(APPEND projects glew)
set(glew_version "2.2.0")
set(glew_url "https://github.com/nigels-com/glew/releases/download/glew-${glew_version}/glew-${glew_version}.tgz")
set(glew_sha256 "d4fc82893cfb00109578d0a1a2337fb8ca335b3ceccf97b97e5cc7f08e4353e1")

# gtest
list(APPEND projects gtest)
set(gtest_version "1.15.2")
set(gtest_url "https://github.com/google/googletest/archive/refs/tags/v${gtest_version}.tar.gz")
set(gtest_sha256 "ad7fdba11ea011c1d925b3289cf4af2c66a352e18d4c7264392fead75e919363")

# hdf5
list(APPEND projects hdf5)
set(hdf5_version "1_10_10")
set(hdf5_url "https://github.com/HDFGroup/hdf5/archive/hdf5-${hdf5_version}.tar.gz")
set(hdf5_sha256 "563940efec30ec027108bc425f45488ce98d356798bdf743441e574c2d52dd54")

# Open Babel
list(APPEND projects openbabel)
#set(openbabel_version "3-1-1")
#set(openbabel_url "https://github.com/openbabel/openbabel/archive/openbabel-${openbabel_version}.tar.gz")
set(openbabel_url "https://github.com/openbabel/openbabel/archive/32cf131444c1555c749b356dab44fb9fe275271f.tar.gz")
set(openbabel_sha256 "7b471015df510b30057b8356f42729a35dfd1f4fa85f205c56bbaf3c64e85071")

# PCRE
list(APPEND projects pcre)
set(pcre_version "8.45")
set(pcre_url "https://sourceforge.net/projects/pcre/files/pcre/${pcre_version}/pcre-${pcre_version}.tar.gz/download")
set(pcre_sha256 "4e6ce03e0336e8b4a3d6c2b70b1c5e18590a5673a98186da90d4f33c23defc09")

# libxml2
list(APPEND projects libxml2)
set(libxml2_version "2.10.4")
set(libxml2_url "https://gitlab.gnome.org/GNOME/libxml2/-/archive/v${libxml2_version}/libxml2-v${libxml2_version}.tar.gz")
set(libxml2_sha256 "7a4fe33f42abff6e4df8b153b4a527d59a6ed957f5621d9142ed68d4a473b1b5")

# Zlib
list(APPEND projects zlib)
set(zlib_version "1.3.1")
set(zlib_url "https://github.com/madler/zlib/archive/v${zlib_version}.tar.gz")
set(zlib_sha256 "629380c90a77b964d896ed37163f5c3a34f6e6d897311f1df2a7016355c45eff")

# KDSoap
list(APPEND projects kdsoap)
set(kdsoap_version "1.10.0")
set(kdsoap_url "https://github.com/KDAB/KDSoap/releases/download/kdsoap-${kdsoap_version}/kdsoap-${kdsoap_version}.tar.gz")
set(kdsoap_sha256 "0c606ecc434466dbadb2829820ca163af60cc7ca226f553b5d4032196737338f")

# spglib
list(APPEND projects spglib)
set(spglib_version "2.5.0")
set(spglib_url "https://github.com/spglib/spglib/archive/v${spglib_version}.tar.gz")
set(spglib_sha256 "b6026f5e85106c0c9ee57e54b9399890d0f29982e20e96ede0428b3efbe6b914")

# libarchive
list(APPEND projects libarchive)
set(libarchive_version "3.7.7")
set(libarchive_url "https://github.com/libarchive/libarchive/archive/v${libarchive_version}.tar.gz")
set(libarchive_sha256 "fa62384995e8aa4f5a901c184fb5c91e56a29e24c05b6881a7f8fd5bbea694d2")

# msgpackc
list(APPEND projects msgpackc)
set(msgpackc_version "3.3.0")
set(msgpackc_url "https://github.com/msgpack/msgpack-c/releases/download/cpp-${msgpackc_version}/msgpack-${msgpackc_version}.tar.gz")
set(msgpackc_sha256 "6e114d12a5ddb8cb11f669f83f32246e484a8addd0ce93f274996f1941c1f07b")

# mmtf-cpp
list(APPEND projects mmtf-cpp)
set(mmtfcpp_version "1.1.0")
set(mmtfcpp_url "https://github.com/rcsb/mmtf-cpp/archive/v${mmtfcpp_version}.tar.gz")
set(mmtfcpp_sha256 "021173bdc1814b1d0541c4426277d39df2b629af53151999b137e015418f76c0")

# libmsym
list(APPEND projects libmsym)
IF (WIN32)
  set(libmsym_url "https://github.com/mcodev31/libmsym/archive/0c47befe4a1cd05cbba1aa561b914be926e5ced7.tar.gz")
  set(libmsym_sha256 "7a8ef0eaaa3319fbf2bd4c829395706b9b28e76adad65385851c491f81cf196f")
ELSE()
  set(libmsym_url "https://github.com/mcodev31/libmsym/archive/85e47232376a8e735c2a7b5283f40b59b3953db1.tar.gz")
  set(libmsym_sha256 "3741ebe163cf40696570d6b62e4834ca587d43dcac9de713994cc5e2960fb8fd")
ENDIF()
