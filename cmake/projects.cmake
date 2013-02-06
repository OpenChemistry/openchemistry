unset(projects)

# Boost
list(APPEND projects boost)
set(_v 51)
set(boost_version 1.${_v}.0)
set(boost_url "http://sourceforge.net/projects/boost/files/boost/1.${_v}.0/boost_1_${_v}_0.tar.gz/download")
set(boost_md5 "6a1f32d902203ac70fbec78af95b3cf8")

# Chemkit
list(APPEND projects chemkit)
set(chemkit_version "0.1-d42dd8d7")
set(chemkit_url "http://openchemistry.org/files/tpl/chemkit-${chemkit_version}.tar.gz")
set(chemkit_md5 "0bae7c476637ef732b38b28ca51a193e")

# Eigen
list(APPEND projects eigen)
set(eigen_version "3.1.2")
set(eigen_url "http://openchemistry.org/files/tpl/eigen-${eigen_version}.tar.gz")
set(eigen_md5 "bb639388192cb80f1ee797f5dbdbe74f")

# glew
list(APPEND projects glew)
set(glew_version "1.7.0")
set(glew_url "http://sourceforge.net/projects/glew/files/glew/${glew_version}/glew-${glew_version}.tgz/download")
set(glew_md5 "fb7a8bb79187ac98a90b57f0f27a3e84")

# gtest
list(APPEND projects gtest)
set(gtest_version "1.6.0")
set(gtest_url "http://googletest.googlecode.com/files/gtest-${gtest_version}.zip")
set(gtest_md5 "4577b49f2973c90bf9ba69aa8166b786")

# hdf5
list(APPEND projects hdf5)
set(hdf5_version "1.8.9")
set(hdf5_url "http://www.hdfgroup.org/ftp/HDF5/releases/hdf5-${hdf5_version}/src/hdf5-${hdf5_version}.tar.gz")
set(hdf5_md5 "d1266bb7416ef089400a15cc7c963218")

# mongodb
list(APPEND projects mongodb)
set(mongodb_version "2.3.0")
#set(mongodb_url "http://downloads.mongodb.org/src/mongodb-src-r${mongodb_version}.tar.gz")
set(mongodb_url "http://openchemistry.org/files/tpl/mongodb-mongo-r${mongodb_version}-75-g5cbd476.tar.gz")
set(mongodb_md5 "6123ff30262dbac822bad27f447dc9a6")

# Open Babel
list(APPEND projects openbabel)
set(openbabel_version "2.3.2")
set(openbabel_url "http://sourceforge.net/projects/openbabel/files/openbabel/${openbabel_version}/openbabel-${openbabel_version}.tar.gz/download")
set(openbabel_md5 "9b0007560d9d838b40ab4ad06daf5610")

# PCRE
list(APPEND projects pcre)
set(pcre_version "8.30")
set(pcre_url "ftp://ftp.csx.cam.ac.uk/pub/software/programming/pcre/pcre-${pcre_version}.tar.gz")
set(pcre_md5 "d5ee0d9f6d2f0b7489331d04b6c182ef")

# libxml2
list(APPEND projects libxml2)
set(libxml2_version "2.7.8")
set(libxml2_url "ftp://xmlsoft.org/libxml2/libxml2-${libxml2_version}.tar.gz")
set(libxml2_md5 "8127a65e8c3b08856093099b52599c86")

# Zlib
list(APPEND projects zlib)
set(zlib_version "1.2.7")
set(zlib_url "http://zlib.net/zlib-${zlib_version}.tar.gz")
set(zlib_md5 "60df6a37c56e7c1366cca812414f7b85")

# KDSoap
list(APPEND projects kdsoap)
set(kdsoap_version "f3bbcf1e")
set(kdsoap_url "http://openchemistry.org/files/tpl/kdsoap-${kdsoap_version}.tar.gz")
set(kdsoap_md5 "d2dcf62844d9e5919ba21788a375feca")
