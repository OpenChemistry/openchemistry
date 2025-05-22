unset(projects)

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
set(gtest_version "1.15.2")
set(gtest_url "https://github.com/google/googletest/archive/refs/tags/v${gtest_version}.tar.gz")
set(gtest_md5 "7e11f6cfcf6498324ac82d567dcb891e")

# hdf5
list(APPEND projects hdf5)
set(hdf5_version "1_10_10")
set(hdf5_url "https://github.com/HDFGroup/hdf5/archive/hdf5-${hdf5_version}.tar.gz")
set(hdf5_md5 "c9e7f394e7b87c00d6d3bf00c0009654")

# Open Babel
list(APPEND projects openbabel)
#set(openbabel_version "3-1-1")
#set(openbabel_url "https://github.com/openbabel/openbabel/archive/openbabel-${openbabel_version}.tar.gz")
set(openbabel_url "https://github.com/openbabel/openbabel/archive/32cf131444c1555c749b356dab44fb9fe275271f.tar.gz")
set(openbabel_md5 "69af3ace345d59cf501c25b3a66259d7")

# PCRE
list(APPEND projects pcre)
set(pcre_version "8.45")
set(pcre_url "https://sourceforge.net/projects/pcre/files/pcre/${pcre_version}/pcre-${pcre_version}.tar.gz/download")
set(pcre_md5 "3bcd2441024d00009a5fee43f058987c")

# libxml2
list(APPEND projects libxml2)
set(libxml2_version "2.10.4")
set(libxml2_url "https://gitlab.gnome.org/GNOME/libxml2/-/archive/v${libxml2_version}/libxml2-v${libxml2_version}.tar.gz")
set(libxml2_md5 "af682edd332aa9940c02c66dcbe4ccf3")

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
set(spglib_version "2.5.0")
set(spglib_url "https://github.com/spglib/spglib/archive/v${spglib_version}.tar.gz")
set(spglib_md5 "13cdcdac341e1cd059502758f2721e70")

# libarchive
list(APPEND projects libarchive)
set(libarchive_version "3.7.7")
set(libarchive_url "https://github.com/libarchive/libarchive/archive/v${libarchive_version}.tar.gz")
set(libarchive_md5 "26946b891d361a8dfc70c10e242cabae")

# libmsym
list(APPEND projects libmsym)
set(libmsym_version "0.2.3-paper")
IF (WIN32)
  set(libmsym_url "https://github.com/mcodev31/libmsym/archive/0c47befe4a1cd05cbba1aa561b914be926e5ced7.tar.gz")
  set(libmsym_md5 "369eb1c447c317a4482a3d560fcdb648")
ELSE()
  set(libmsym_url "https://github.com/mcodev31/libmsym/archive/refs/tags/v${libmsym_version}.tar.gz")
  set(libmsym_md5 "1221f9f0b1efefe061b0afbf8cf72481")
ENDIF()
