#=======================================================================
#                   define the compiler names
#=======================================================================

F90 = gfortran
#F90 = ifort

#=======================================================================
#                     additional flags
#=======================================================================
ifeq ($(F90),gfortran)
	F90FLAGS = -fPIC -O3 -fopenmp -fdefault-real-8 -fdefault-integer-8 -ffree-line-length-512
    FCOMP = gnu95 --compiler=mingw32
endif

ifeq ($(F90),ifort)
	F90FLAGS = /nologo /O3 /assume:nocc_omp /Qopenmp /real-size:64 /fp:precise /libs:static /threads
    FCOMP = intelvem # for f2py
endif

FPP = gfortran -E # gfortran f90wrap temp files only, not compilation
FPP_F90FLAGS = -x f95-cpp-input -fPIC
CC = gcc
CFLAGS = -fPIC # ==> universal for ifort, gfortran, pgi

LIBTOOL = ar src

# ======================================================================
# PROJECT CONFIG, do not put spaced behind the variables
# ======================================================================
# Python module name
PYTHON_MODN = MagTenseSource
# mapping between Fortran and C types
KIND_MAP = kind_map

#=======================================================================
#       List all source files required for the project
#=======================================================================
# names (without suffix), f90 sources
LIBSRC_SOURCES = IntegrationDataTypes quadpack SpecialFunctions TileTensorHelperFunctions TileRectangularPrismTensor TileCircPieceTensor TileCylPieceTensor TilePlanarCoilTensor TileNComponents DemagFieldGetSolution

# file names
LIBSRC_FILES = $(addsuffix .f90,${LIBSRC_SOURCES})

# object files
LIBSRC_OBJECTS = $(addsuffix .o,${LIBSRC_SOURCES})

# only used when cleaning up
LIBSRC_FPP_FILES = $(addsuffix .fpp,${LIBSRC_SOURCES})

#=======================================================================
#       List all source files that require a Python interface
#=======================================================================
# names (without suffix), f90 sources
LIBSRC_WRAP_SOURCES = FortranToPythonIO

# file names
LIBSRC_WRAP_FILES = $(addsuffix .f90,${LIBSRC_WRAP_SOURCES})

# object files
LIBSRC_WRAP_OBJECTS = $(addsuffix .o,${LIBSRC_WRAP_SOURCES})

# fpp files
LIBSRC_WRAP_FPP_FILES = $(addsuffix .fpp,${LIBSRC_WRAP_SOURCES})

# f90wrap files
LIBSRC_F90WRAP_FILES = $(addprefix f90wrap_,${LIBSRC_WRAP_FILES})

#=======================================================================
#                 Relevant suffixes
#=======================================================================
.SUFFIXES: .f90 .fpp

#=======================================================================
#
#=======================================================================
.PHONY: all clean

all: _${PYTHON_MODN}.pyd

clean:
	-del ${LIBSRC_OBJECTS} ${LIBSRC_FPP_FILES} ${PYTHON_MODN}.py libsrc.a *.mod f90wrap* .f2py_f2cmap *.pyd
	-rmdir Release src.win-amd64-3.7 __pycache__ /s /Q

.f90.o:
	${F90} ${F90FLAGS} -c $< -o $@

.c.o:
	${CC} ${CFLAGS} -c $< -o $@

.f90.fpp:
	${FPP} ${FPP_F90FLAGS} $< -o $@

libsrc.a: ${LIBSRC_OBJECTS}
	${LIBTOOL} $@ $?

_${PYTHON_MODN}.pyd: libsrc.a
	f2py --build-dir . --fcompiler=${FCOMP} --opt='${F90FLAGS}' -c -m ${PYTHON_MODN} -L. -lsrc ${LIBSRC_WRAP_FILES} ${LIBSRC_OBJECTS}
#	f90wrap -m ${PYTHON_MODN} ${LIBSRC_WRAP_FPP_FILES} -k ${KIND_MAP} -v
#	f2py-f90wrap --build-dir . --fcompiler=${FCOMP} --opt='${F90FLAGS}' -c -m _${PYTHON_MODN} -L. -lsrc ${LIBSRC_F90WRAP_FILES} ${LIBSRC_OBJECTS}
