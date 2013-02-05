# use system libxml2 by default on unix
if(UNIX)
  set(DEFAULT_USE_SYSTEM_LIBXML2 ON)
else()
  set(DEFAULT_USE_SYSTEM_LIBXML2 OFF)
endif()

option(USE_SYSTEM_BOOST "Should we use the system Boost?" OFF)
option(USE_SYSTEM_MONGODB "Should we use the system mongoDB?" OFF)
option(USE_SYSTEM_PCRE "Should we use the system PCRE?" OFF)
option(USE_SYSTEM_LIBXML2 "Should we use the system libxml2?" ${DEFAULT_USE_SYSTEM_LIBXML2})
option(USE_SYSTEM_ZLIB "Should we use the system zlib?" OFF)
option(USE_SYSTEM_EIGEN "Should we use the system Eigen?" OFF)
option(USE_SYSTEM_GLEW "Should we use the system GLEW?" OFF)
option(USE_SYSTEM_GTEST "Should we use the system GTest?" OFF)
option(USE_SYSTEM_HDF5 "Should we use the system HDF5?" OFF)

if(USE_SYSTEM_ZLIB)
  find_package(ZLIB REQUIRED)
  list(APPEND OpenChemistry_THIRDPARTYLIBS_ARGS
    "-DZLIB_INCLUDE_DIRS:PATH=${ZLIB_INCLUDE_DIRS}"
    "-DZLIB_LIBRARIES:FILEPATH=${ZLIB_LIBRARIES}")
else()
  include(External_zlib)
endif()

if(USE_SYSTEM_BOOST)
  find_package(Boost REQUIRED)
  list(APPEND OpenChemistry_THIRDPARTYLIBS_ARGS
    "-DBoost_INCLUDE_DIR:PATH=${Boost_INCLUDE_DIR}"
    "-DBOOST_LIBRARYDIR:PATH=${BOOST_LIBRARYDIR}")
else()
  include(External_boost)
endif()

# FIXME: Add system options, test them and expose the CMake options.
if(USE_SYSTEM_PCRE)
  message(FATAL_ERROR "find_package(PCRE) is not yet implemented")
else()
  include(External_pcre)
endif()

if(USE_SYSTEM_MONGODB)
  find_package(MongoDB REQUIRED)
  list(APPEND OpenChemistry_THIRDPARTYLIBS_ARGS
    "-DMongoDB_INCLUDE_DIR:PATH=${MongoDB_INCLUDE_DIR}"
    "-DMongoDB_LIBRARIES:FILEPATH=${MongoDB_LIBRARIES}")
else()
  include(External_mongodb)
endif()

if(USE_SYSTEM_LIBXML2)
  find_package(LibXml2 REQUIRED)
else()
  include(External_libxml2)
endif()

if(USE_SYSTEM_EIGEN)
  find_package(Eigen3 REQUIRED)
  list(APPEND OpenChemistry_THIRDPARTYLIBS_ARGS
    "-DEIGEN3_INCLUDE_DIR:PATH=${EIGEN3_INCLUDE_DIR}")
else()
  include(External_eigen)
endif()

if(USE_SYSTEM_GLEW)
  find_package(GLEW REQUIRED)
  list(APPEND OpenChemistry_THIRDPARTYLIBS_ARGS
    "-DGLEW_INCLUDE_DIRS:PATH=${GLEW_INCLUDE_DIRS}"
    "-DGLEW_LIBRARY:FILEPATH=${GLEW_LIBRARY}")
else()
  include(External_glew)
endif()

if(USE_SYSTEM_GTEST)
  find_package(GTest REQUIRED)
else()
  include(External_gtest)
endif()

if(USE_SYSTEM_HDF5)
  find_package(HDF5 REQUIRED)
else()
  include(External_hdf5)
endif()

# FIXME: Add system options, test them and expose the CMake options.
if(USE_SYSTEM_OPENBABEL)
  message(FATAL_ERROR "find_package(OpenBabel2) is not yet implemented")
else()
#  include(External_openbabel)
endif()

# FIXME: Add system options, test them and expose the CMake options.
if(USE_SYSTEM_CHEMKIT)
  message(FATAL_ERROR "find_package(Chemkit) is not yet implemented")
else()
  include(External_chemkit)
endif()

if(USE_SYSTEM_VTK)
  find_package(VTK REQUIRED)
else()
  include(External_VTK)
endif()

include(External_qttesting)
include(External_kdsoap)

set(OpenChemistry_THIRDPARTYLIBS_ARGS "${OpenChemistry_THIRDPARTYLIBS_ARGS}"
  CACHE INTERNAL "Third party library cache arguments")
