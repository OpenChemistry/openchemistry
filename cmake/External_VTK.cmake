# Pick out the modules used in MongoChem and AvogadroLibs only.
set(_source "${CMAKE_CURRENT_SOURCE_DIR}/VTK")
set(_build "${CMAKE_CURRENT_BINARY_DIR}/VTK")

ExternalProject_Add(VTK
  SOURCE_DIR ${_source}
  BINARY_DIR ${_build}
  CMAKE_ARGS
    ${OpenChemistry_DEFAULT_ARGS}
    -DVTK_Group_Rendering:BOOL=OFF
    -DVTK_Group_StandAlone:BOOL=OFF
    -DModule_vtkDomainsChemistry:BOOL=ON
    -DModule_vtkViewsContext2D:BOOL=ON
    -DModule_vtkChartsCore:BOOL=ON
    -DModule_vtkRenderingVolumeOpenGL:BOOL=ON
    -DModule_vtkGUISupportQtOpenGL:BOOL=ON
    -DModule_vtkRenderingQt:BOOL=ON
    -DModule_vtkViewsInfovis:BOOL=ON
    -DModule_vtkRenderingFreeTypeOpenGL:BOOL=ON
  )
