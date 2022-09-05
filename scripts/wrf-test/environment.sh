#!/bin/bash -l

module purge
module load beta-modules
module load gcc-libs/9.2.0
module load compilers/gnu/9.2.0
module load python/3.8.6
module load git
module load cmake

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
modjpeg=$(ls | grep libjpeg)

echo "OpenMPI module:         $modopenmpi"
echo "NetCDF parallel module: $modnetcdfp"
echo "NetCDF C module:        $modnetcdfc"
echo "NetCDF Fortran module:  $modnetcdff"
echo "Jasper module:          $modjasp"
echo "PNG module:             $modpng"
echo "JPED module             $modjpeg"
echo "Zlib module:            $modz"
echo "Perl module:            $modperl"
echo "HDF5 module:            $modhdf"
echo "M4 module:              $modm4"
echo "Libtool module:         $modlt"

module use --append ~/Source/wrf/deps/spack/share/spack/modules/$spackarch

module load $modopenmpi $modnetcdfp $modnetcdfc $modnetcdff $modjasp $modpng $modz $modperl $modhdf $modm4 $modlt $modjpeg

cd ~/Source/wrf/deps/spack/opt/spack/$spackarch/gcc-9.2.0
ncdir=$(ls | grep netcdf-fortran-)
nccdir=$(ls | grep netcdf-c-)
jaspdir=$(ls | grep jasper-)
jpegdir=$(ls | grep libjpeg-)

echo "BRAVELY MERGING NETCDF!!!"
rsync -av "$HOME/Source/wrf/deps/spack/opt/spack/$spackarch/gcc-9.2.0/$nccdir/" "$HOME/Source/wrf/deps/spack/opt/spack/$spackarch/gcc-9.2.0/$ncdir/"
rsync -av "$HOME/Source/wrf/deps/spack/opt/spack/$spackarch/gcc-9.2.0/$ncdir/" "$HOME/Source/wrf/deps/spack/opt/spack/$spackarch/gcc-9.2.0/$nccdir/"
echo "MERGE COMPLETE!!"

export NETCDF="$HOME/Source/wrf/deps/spack/opt/spack/$spackarch/gcc-9.2.0/$ncdir"
export NETCDF_classic=1
export NETCDFF=$NETCDF
export NETCDFC="$HOME/Source/wrf/deps/spack/opt/spack/$spackarch/gcc-9.2.0/$nccdir"
export JASPERLIB="$HOME/Source/wrf/deps/spack/opt/spack/$spackarch/gcc-9.2.0/$jaspdir/lib64"
export JASPERINC="$HOME/Source/wrf/deps/spack/opt/spack/$spackarch/gcc-9.2.0/$jaspdir/include"
export LD_LIBRARY_PATH="$HOME/Source/wrf/deps/spack/opt/spack/$spackarch/gcc-9.2.0/$jpegdir/lib64:$HOME/Source/wrf/deps/spack/opt/spack/$spackarch/gcc-9.2.0/$ncdir/lib:$HOME/Source/wrf/deps/spack/opt/spack/$spackarch/gcc-9.2.0/$nccdir/lib:$LD_LIBRARY_PATH"

cd $oldpwd
