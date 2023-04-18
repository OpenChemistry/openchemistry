# use system libxml2 by default on unix
if(UNIX)
  set(DEFAULT_USE_SYSTEM_LIBXML2 ON)
else()
  set(DEFAULT_USE_SYSTEM_LIBXML2 OFF)
endif()

option(USE_SYSTEM_LIBXML2 "Should we use the system libxml2?" ${DEFAULT_USE_SYSTEM_LIBXML2})
option(USE_SYSTEM_ZLIB "Should we use the system zlib?" OFF)
option(USE_SYSTEM_EIGEN "Should we use the system Eigen?" OFF)
option(USE_SYSTEM_GLEW "Should we use the system GLEW?" OFF)
option(USE_SYSTEM_GTEST "Should we use the system GTest?" OFF)
option(USE_SYSTEM_HDF5 "Should we use the system HDF5?" OFF)
option(USE_SYSTEM_OPENBABEL "Should we use the system Open Babel?" OFF)
option(USE_SYSTEM_LIBARCHIVE "Should we use the system Libarchive?" OFF)

if(USE_SYSTEM_LIBARCHIVE)
  find_package(LIBARCHIVE REQUIRED)
  list(APPEND OpenChemistry_THIRDPARTYLIBS_ARGS
    "-DLIBARCHIVE_INCLUDE_DIRS:PATH=${LIBARCHIVE_INCLUDE_DIRS}"
    "-DLIBARCHIVE_LIBRARIES:FILEPATH=${LIBARCHIVE_LIBRARIES}")
else()
  include(External_libarchive)
endif()

if(USE_SYSTEM_ZLIB)
  find_package(ZLIB REQUIRED)
  list(APPEND OpenChemistry_THIRDPARTYLIBS_ARGS
    "-DZLIB_INCLUDE_DIRS:PATH=${ZLIB_INCLUDE_DIRS}"
    "-DZLIB_LIBRARIES:FILEPATH=${ZLIB_LIBRARIES}")
else()
  include(External_zlib)
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

if(BUILD_AVOGADRO OR BUILD_MONGOCHEM)
  if(USE_SYSTEM_GLEW)
    find_package(GLEW REQUIRED)
    list(APPEND OpenChemistry_THIRDPARTYLIBS_ARGS
      "-DGLEW_INCLUDE_DIRS:PATH=${GLEW_INCLUDE_DIRS}"
      "-DGLEW_LIBRARY:FILEPATH=${GLEW_LIBRARY}")
  else()
    include(External_glew)
  endif()
  if(USE_PYTHON)
    include(External_pybind11)
  endif()
  if(USE_HDF5 AND USE_SYSTEM_HDF5)
    find_package(HDF5 REQUIRED)
  elseif(USE_HDF5)
    include(External_hdf5)
  endif()
endif()

if(BUILD_AVOGADRO)
  include(External_spglib)
  include(External_libmsym)
  include(External_msgpackc)
  include(External_mmtfcpp)
endif()

if(ENABLE_TESTING)
  if(USE_SYSTEM_GTEST)
    find_package(GTest REQUIRED)
  else()
    include(External_gtest)
  endif()
  include(External_qttesting)
endif()

# FIXME: Add system options, test them and expose the CMake options.
if(USE_SYSTEM_OPENBABEL)
  message(STATUS "Using system Open Babel")
else()
  include(External_openbabel)
endif()

if(BUILD_AVOGADRO AND USE_VTK)
  if(USE_SYSTEM_VTK)
    find_package(VTK REQUIRED)
  else()
    include(External_VTK)
  endif()
endif()

if(BUILD_AVOGADRO AND USE_YAEHMOP)
  include(External_yaehmop)
endif()

if(BUILD_MOLEQUEUE AND BUILD_MOLEQUEUE_UIT)
  include(External_kdsoap)
endif()

set(OpenChemistry_THIRDPARTYLIBS_ARGS "${OpenChemistry_THIRDPARTYLIBS_ARGS}"
  PARENT_SCOPE)
