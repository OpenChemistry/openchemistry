# Pick out the modules used in MongoChem and AvogadroLibs only.
set(_source "${CMAKE_CURRENT_SOURCE_DIR}/VTK")
set(_build "${CMAKE_CURRENT_BINARY_DIR}/VTK")

unset(_deps)
add_optional_deps(_deps "zlib" "eigen")

ExternalProject_Add(VTK
  SOURCE_DIR ${_source}
  BINARY_DIR ${_build}
  CMAKE_CACHE_ARGS
    ${OpenChemistry_DEFAULT_ARGS}
    -DBUILD_TESTING:BOOL=OFF
    -DVTK_Group_Rendering:BOOL=OFF
    -DVTK_Group_StandAlone:BOOL=OFF
    -DModule_vtkDomainsChemistry:BOOL=ON
    -DModule_vtkViewsContext2D:BOOL=ON
    -DModule_vtkChartsCore:BOOL=ON
    -DModule_vtkRenderingVolumeOpenGL2:BOOL=ON
    -DModule_vtkGUISupportQt:BOOL=ON
    -DModule_vtkRenderingQt:BOOL=ON
    -DModule_vtkViewsInfovis:BOOL=OFF
    -DModule_vtkRenderingFreeTypeOpenGL2:BOOL=ON
    ${OpenChemistry_THIRDPARTYLIBS_ARGS}
    -DVTK_USE_SYSTEM_ZLIB:BOOL=ON
    -DVTK_USE_SYSTEM_EIGEN:BOOL=ON
    -DVTK_BUILD_QT_DESIGNER_PLUGIN:BOOL=OFF
    -DVTK_QT_VERSION:STRING=5
  DEPENDS
    ${_deps}
  )
