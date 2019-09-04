#!/bin/bash -l

set -e

for i in ${includes_dir:=$(dirname $0 2>/dev/null)/includes}/{module_maker,require}_inc.sh; do . $i; done

require gcc-libs/4.9.2
require compilers/intel/2017/update1
require mpi/intel/2017/update1/intel
require hdf/5-1.8.15-p1-impi/intel-2015-update2

export OPS_INSTALL_PATH=$HOME/Source/archer-benchmarks/apps/OpenSBLI/source/OPS/ops

export MPICC_CC=icc
export MPICXX_CXX=icpc
export OPS_COMPILER=intel
export MPI_INSTALL_PATH=/shared/ucl/apps/intel/2017.Update1/impi/2017.1.132/intel64
export HDF5_INSTALL_PATH=/shared/ucl/apps/hdf5/1.8.15-p1-impi/intel-2015-update2

cd ${OPS_INSTALL_PATH}/c

make clean
make -f Makefile.ucl mpi

cd ../../../Benchmark

make clean
make -f Makefile.ucl OpenSBLI_mpi
