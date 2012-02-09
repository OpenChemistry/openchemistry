unset(projects)

# Boost
list(APPEND projects boost)
set(_v 48)
set(boost_version 1.${_v}.0)
set(boost_url "http://sourceforge.net/projects/boost/files/boost/1.${_v}.0/boost_1_${_v}_0.tar.gz/download")
set(boost_md5 "313a11e97eb56eb7efd18325354631be")

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
