unset(projects)

# The base URL for all hosted files to use when downloading
if(DEFINED OpenChemistry_DOWNLOAD_BASE_URL)
  set(oc_download_base ${OpenChemistry_DOWNLOAD_BASE_URL})
else()
  set(oc_download_base "http://www.openchemistry.org/files")
endif()

# Boost
list(APPEND projects boost)
set(_v 55)
set(boost_version 1.${_v}.0)
set(boost_url "http://sourceforge.net/projects/boost/files/boost/1.${_v}.0/boost_1_${_v}_0.tar.gz/download")
set(boost_md5 "93780777cfbf999a600f62883bd54b17")

# Chemkit
list(APPEND projects chemkit)
set(chemkit_version "0.1-d42dd8d7")
set(chemkit_url "${oc_download_base}/tpl/chemkit-${chemkit_version}.tar.gz")
set(chemkit_md5 "0bae7c476637ef732b38b28ca51a193e")

# Eigen
list(APPEND projects eigen)
set(eigen_version "3.2.1")
set(eigen_url "${oc_download_base}/tpl/eigen-${eigen_version}.tar.gz")
set(eigen_md5 "a0e0a32d62028218b1c1848ad7121476")

# glew
list(APPEND projects glew)
set(glew_version "1.10.0")
set(glew_url "http://sourceforge.net/projects/glew/files/glew/${glew_version}/glew-${glew_version}.tgz/download")
set(glew_md5 "2f09e5e6cb1b9f3611bcac79bc9c2d5d")

# gtest
list(APPEND projects gtest)
set(gtest_version "1.7.0")
set(gtest_url "http://googletest.googlecode.com/files/gtest-${gtest_version}.zip")
set(gtest_md5 "2d6ec8ccdf5c46b05ba54a9fd1d130d7")

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
set(openbabel_version "ca45cc9a")
#set(openbabel_url "http://sourceforge.net/projects/openbabel/files/openbabel/${openbabel_version}/openbabel-${openbabel_version}.tar.gz/download")
set(openbabel_url "${oc_download_base}/tpl/openbabel-${openbabel_version}.tar.gz")
set(openbabel_md5 "d1d50c39562b38432f3b49268cc96209")

# PCRE
list(APPEND projects pcre)
set(pcre_version "8.34")
set(pcre_url "${oc_download_base}/tpl/pcre-${pcre_version}.tar.gz")
set(pcre_md5 "eb34b2c9c727fd64940d6fd9a00995eb")

# libxml2
list(APPEND projects libxml2)
set(libxml2_version "2.9.1")
set(libxml2_url "${oc_download_base}/tpl/libxml2-${libxml2_version}.tar.gz")
set(libxml2_md5 "9c0cfef285d5c4a5c80d00904ddab380")

# Zlib
list(APPEND projects zlib)
set(zlib_version "1.2.8")
set(zlib_url "${oc_download_base}/tpl/zlib-${zlib_version}.tar.gz")
set(zlib_md5 "44d667c142d7cda120332623eab69f40")

# KDSoap
list(APPEND projects kdsoap)
set(kdsoap_version "f3bbcf1e")
set(kdsoap_url "${oc_download_base}/tpl/kdsoap-${kdsoap_version}.tar.gz")
set(kdsoap_md5 "d2dcf62844d9e5919ba21788a375feca")
