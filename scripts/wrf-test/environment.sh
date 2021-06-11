#!/bin/bash -l

module purge
module load beta-modules
module load gcc-libs/9.2.0
module load compilers/gnu/9.2.0
module load python/3.8.6

oldpwd=$(pwd)
cd ~/Source/wrf/deps/spack/share/spack/modules
spackarch=$(ls | grep linux-rhel)
cd $spackarch

modopenmpi=$(ls | grep openmpi)
modnetcdfp=$(ls | grep parallel-netcdf)
modnetcdfc=$(ls | grep netcdf-c)
modnetcdff=$(ls | grep netcdf-fortran)
modjasp=$(ls | grep jasper)
modpng=$(ls | grep libpng)
modz=$(ls | grep zlib)
modperl=$(ls | grep perl)
modhdf=$(ls | grep hdf5)
modm4=$(ls | grep m4)
modlt=$(ls | grep libtool)

echo "OpenMPI module:         $modopenmpi"
echo "NetCDF parallel module: $modnetcdfp"
echo "NetCDF C module:        $modnetcdfc"
echo "NetCDF Fortran module:  $modnetcdff"
echo "Jasper module:          $modjasp"
echo "PNG modue:              $modpng"
echo "Zlib module:            $modz"
echo "Perl module:            $modperl"
echo "HDF5 module:            $modhdf"
echo "M4 module:              $modm4"
echo "Libtool module:         $modlt"

cd $oldpwd

module use --append ~/Source/wrf/deps/spack/share/spack/modules/$spackarch

module load $modopenmpi $modnetcdfp $modnetcdfc $modnetcdff $modjasp $modpng $modz $modperl $modhdf $modm4 $modlt


export NETCDF="$HOME/Source/wrf/deps/spack/opt/spack/$spackarch/gcc-9.2.0/netcdf-fortran-*"
export NETCDF_classic=1
