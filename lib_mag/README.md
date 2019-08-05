# Lib folder contains adjusted Fortran source code of MagTense application
- IntegrationDataTypes.f90 
- quadpack.f90 
- SpecialFunctions.f90 
- TileTensorHelperFunctions.f90 
- TileRectangularPrismTensor.f90 
- TileCircPieceTensor.f90 
- TileCylPieceTensor.f90 
- TilePlanarCoilTensor.f90 
- TileNComponents.f90

## Adjustments to source code to be compatible with gfortran compiler
- IntegrationDataTypes.f90
    ```
    class( dataCollectionModelBase ) ---> type(dataCollectionModelBase)
    class( dataCollectionBase ) :: dat ---> type(dataCollectionBase),target :: dat
    ```
- quadpack.f90
    ```
    class(dataCollectionModelBase) ---> type(dataCollectionModelBase)
    0.0d+00 ---> 0.0E+00
    ```
- TileCircPieceTensor.f90
    ```
    class(dataCollectionModelBase) ---> type(dataCollectionModelBase)
    ```
- TileCylPieceTensor.f90
    ```
    class(dataCollectionModelBase) ---> type(dataCollectionModelBase)

    omitting "intent(inout)" in functions int_cos_dDdz_dz_dtheta_fct_int(), int_dDdy_dr_dz_fct_int() and int_r_dDdz_dr_dtheta_fct_int()
    ```
- TilePlanarCoilTensor.f90
    ```
    class(dataCollectionModelBase) ---> type(dataCollectionModelBase)
    ```
- TileNComponents.f90
    ```
    deleting abstract interface (subroutine N_tensor_subroutine)
    class(dataCollectionModelBase) ---> type(dataCollectionModelBase)
    real,intent(out),dimension(3,3) :: N_out ---> real,intent(inout),dimension(3,3) :: N_out
    ```  

# Creating importable Python module from Fortran source code (**.pyd** on Windows / **.so** on Linux)
Requirements:
- Python installation
- Numpy package
- Fortran compiler: gfortran of ifort
- f90wrap [Github Repo](https://github.com/jameskermode/f90wrap)

## Adjustments to get f90wrap running on Windows
- Installation:
    ```
    git clone https://github.com/jameskermode/f90wrap
    cd f90wrap 
    python setup.py install
    ```

- Copy created library 'libsizeoffo.RANDOMSEQUENCE.gfortran-win_amd64.dll of folder '..\venv\Lib\site-packages\f90wrap-0.1.4-py3.7-win-amd64.egg\.libs' to '..\venv\Lib\site-packages\f90wrap-0.1.4-py3.7-win-amd64.egg'

- Adjust script f2py-f90wrap in folder '..\venv\Lib\site-packages\f90wrap-0.1.4-py3.7-win-amd64.egg'
    Add following lines to code block starting at line 71:
    ```
    #include <setjmpex.h>
    #include <signal.h>
    ```

## Fortran compiler: **gfortran** from MinGW64
Open terminal, navigate to this folder and run Makefile in activated Python virtual environment:
```
cd PATH\TO\THIS\FOLDER
..\venv\Scripts\activate.bat
mingw32-make.exe
```

## Fortran compiler: **ifort** compiler from Intel Parallel Studio XE - CURRENTLY NOT WORKING
Change compiler in Makefile to ifort:
```
#F90 = gfortran
F90 = ifort
```

Open terminal, activate Intel Software Environment
```
cd C:\Program Files (x86)\IntelSWTools\compilers_and_libraries_2019\windows\bin\
CALL ifortvars.bat intel64
```

Navigate to this folder, activate Python virtual environment and run Makefile:
```
cd PATH\TO\THIS\FOLDER
..\venv\Scripts\activate.bat
mingw32-make.exe
```
-----> LINKING ERRORS