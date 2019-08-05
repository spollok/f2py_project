# Creating importable Python module from Fortran source code (**.pyd** on Windows / **.so** on Linux)
Requirements:
- Python installation
- Numpy package
- Fortran compiler: gfortran of ifort

## Lib folder contains adjusted Fortran source code of MagTense application
- IntegrationDataTypes.f90 
- quadpack.f90 
- SpecialFunctions.f90 
- TileTensorHelperFunctions.f90 
- TileRectangularPrismTensor.f90 
- TileCircPieceTensor.f90 
- TileCylPieceTensor.f90 
- TilePlanarCoilTensor.f90 
- TileNComponents.f90
- DemagFieldGetSolution.f90

## Fortran file with functions to wrap for Python
- FortranToPythonIO.f90

## Adjustments to source code to be compatible with gfortran compiler
- IntegrationDataTypes.f90
    ```
    class( dataCollectionBase ) :: dat ---> class(dataCollectionBase), intent(inout), target :: dat
    ```
- quadpack.f90
    ```
    0.0d+00 ---> 0.0E+00
    ```
- TileCircPieceTensor.f90
    ```
    class(dataCollectionBase), target :: dat ---> class(dataCollectionBase), intent(inout), target :: dat
    ```
- TileCylPieceTensor.f90
    ```
    class(dataCollectionBase), target :: dat ---> class(dataCollectionBase), intent(inout), target :: dat
    ```
- TilePlanarCoilTensor.f90
    ```
    class(dataCollectionBase), target :: dat ---> class(dataCollectionBase), intent(inout), target :: dat
    ```
- TileNComponents.f90
    ```
    real,intent(out),dimension(3,3) :: N_out ---> real,intent(inout),dimension(3,3) :: N_out
    ```  
- DemagFieldGetSolution.f90
    ```
    eq. ---> eqv.
    ```  

## Fortran compiler: **gfortran** from MinGW64
Open terminal, navigate to this folder and run Makefile in activated Python virtual environment.

- WINDOWS:
    ```
    cd PATH\TO\THIS\FOLDER
    ..\venv\Scripts\activate.bat
    mingw32-make.exe
    ```
-Linux
    ```
    cd PATH/TO/THIS/FOLDER
    source ../venv/bin/activate
    make
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

Navigate to this folder, activate Python virtual environment and run Makefile.

-----> LINKING ERRORS
