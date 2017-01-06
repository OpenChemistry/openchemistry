unset(projects)

# The base URL for all hosted files to use when downloading
if(DEFINED OpenChemistry_DOWNLOAD_BASE_URL)
  set(oc_download_base ${OpenChemistry_DOWNLOAD_BASE_URL})
else()
  set(oc_download_base "http://www.openchemistry.org/files")
endif()

# Boost
list(APPEND projects boost)
set(_v 60)
set(boost_version 1.${_v}.0)
set(boost_url "http://sourceforge.net/projects/boost/files/boost/1.${_v}.0/boost_1_${_v}_0.tar.gz/download")
set(boost_md5 "28f58b9a33469388302110562bdf6188")

# Chemkit
list(APPEND projects chemkit)
set(chemkit_version "0.1-d42dd8d7")
set(chemkit_url "${oc_download_base}/tpl/chemkit-${chemkit_version}.tar.gz")
set(chemkit_md5 "0bae7c476637ef732b38b28ca51a193e")

# Eigen
list(APPEND projects eigen)
set(eigen_version "3.2.8")
set(eigen_url "${oc_download_base}/tpl/eigen-${eigen_version}.tar.gz")
set(eigen_md5 "135d8d43aaee5fb54cf5f3e981b1a6db")

# glew
list(APPEND projects glew)
set(glew_version "1.13.0")
set(glew_url "https://sourceforge.net/projects/glew/files/glew/${glew_version}/glew-${glew_version}.tgz/download")
set(glew_md5 "7cbada3166d2aadfc4169c4283701066")

# gtest
list(APPEND projects gtest)
set(gtest_version "1.7.0")
set(gtest_url "https://github.com/google/googletest/archive/release-${gtest_version}.tar.gz")
set(gtest_md5 "4ff6353b2560df0afecfbda3b2763847")
#set(gtest_md5 "16877098823401d1bf2ed7891d7dce36")

# hdf5
list(APPEND projects hdf5)
set(hdf5_version "1.8.12")
set(hdf5_url "http://www.hdfgroup.org/ftp/HDF5/releases/hdf5-${hdf5_version}/src/hdf5-${hdf5_version}.tar.gz")
set(hdf5_md5 "d804802feb99b87fc668a90e6fa34411")

# mongodb
list(APPEND projects mongodb)
set(mongodb_version "2.3.0")
#set(mongodb_url "http://downloads.mongodb.org/src/mongodb-src-r${mongodb_version}.tar.gz")
set(mongodb_url "${oc_download_base}/tpl/mongodb-mongo-r${mongodb_version}-75-g5cbd476.tar.gz")
set(mongodb_md5 "6123ff30262dbac822bad27f447dc9a6")

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
set(libxml2_version "2.9.4")
set(libxml2_url "${oc_download_base}/tpl/libxml2-${libxml2_version}.tar.gz")
set(libxml2_md5 "ae249165c173b1ff386ee8ad676815f5")

# Zlib
list(APPEND projects zlib)
set(zlib_version "1.2.8")
set(zlib_url "${oc_download_base}/tpl/zlib-${zlib_version}.tar.gz")
set(zlib_md5 "44d667c142d7cda120332623eab69f40")

# KDSoap
list(APPEND projects kdsoap)
set(kdsoap_version "1.5.1-fb44069")
#set(kdsoap_url "https://github.com/KDAB/KDSoap/releases/download/kdsoap-${kdsoap_version}/kdsoap-${kdsoap_version}.tar.gz")
set(kdsoap_url "${oc_download_base}/tpl/kdsoap-${kdsoap_version}.tar.gz")
set(kdsoap_md5 "f9df9bf9bb3378da10f987f3f3dbcd57")

# spglib
list(APPEND projects spglib)
set(spglib_version "1.9")
set(spglib_version_micro "4")
set(spglib_url "https://sourceforge.net/projects/spglib/files/spglib/spglib-${spglib_version}/spglib-${spglib_version}.${spglib_version_micro}.tar.gz/download")
set(spglib_md5 "49efe9b583f799533108c027557557a3")

# libarchive
list(APPEND projects libarchive)
set(libarchive_version "3.2.2")
set(libarchive_url "https://github.com/libarchive/libarchive/archive/v${libarchive_version}.tar.gz")
set(libarchive_md5 "eb7774849c5db9cde9eaa56892197aa3")
