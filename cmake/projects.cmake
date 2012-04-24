unset(projects)

# Boost
list(APPEND projects boost)
set(_v 49)
set(boost_version 1.${_v}.0)
set(boost_url "http://sourceforge.net/projects/boost/files/boost/1.${_v}.0/boost_1_${_v}_0.tar.gz/download")
set(boost_md5 "e0defc8c818e4f1c5bbb29d0292b76ca")

# mongodb
list(APPEND projects mongodb)
set(mongodb_version 2.0.2)
set(mongodb_url "http://downloads.mongodb.org/src/mongodb-src-r2.0.2.tar.gz")
set(mongodb_md5 "5dcf819249955a3e9cc61a341e45403a")

# PCRE
list(APPEND projects pcre)
set(pcre_version 8.21)
set(pcre_url "ftp://ftp.csx.cam.ac.uk/pub/software/programming/pcre/pcre-8.21.tar.gz")
set(pcre_md5 "b8c9469717262a1e486cffc288b28283")

# libxml2
list(APPEND projects libxml2)
set(libxml2_version 2.7.8)
set(libxml2_url "ftp://xmlsoft.org/libxml2/libxml2-${libxml2_version}.tar.gz")
set(libxml2_md5 "8127a65e8c3b08856093099b52599c86")

# Zlib
list(APPEND projects zlib)
set(zlib_version 1.2.6)
set(zlib_url "http://zlib.net/zlib-${zlib_version}.tar.gz")
set(zlib_md5 "618e944d7c7cd6521551e30b32322f4a")
