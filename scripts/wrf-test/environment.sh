#!/bin/bash -l

gccver=${gccver:-9.2.0}
module purge
module load beta-modules
module load gcc-libs/${gccver}
module load compilers/gnu/${gccver}
module load python/3.9.10
module load git
module load cmake

oldpwd=$(pwd)
cd ~/Source/wrf/deps/spack/share/spack/modules
spackarch=$(ls | grep linux-)
cd $spackarch

modopenmpi=$(ls openmpi/* | tail -n 1)
modnetcdfp=$(ls parallel-netcdf/* | tail -n 1)
modnetcdfc=$(ls netcdf-c/* | tail -n 1)
modnetcdff=$(ls netcdf-fortran/* | tail -n 1)
modjasp=$(ls jasper/* | tail -n 1)
modpng=$(ls libpng/* | tail -n 1)
modz=$(ls zlib-ng/* | tail -n 1)
modperl=$(ls perl/* | tail -n 1)
modhdf=$(ls hdf5/* | tail -n 1)
modm4=$(ls m4/* | tail -n 1)
modlt=$(ls libtool/* | tail -n 1)
modjpeg=$(ls libjpeg-turbo/* | tail -n 1)

echo "OpenMPI module:         $modopenmpi"
echo "NetCDF parallel module: $modnetcdfp"
echo "NetCDF C module:        $modnetcdfc"
echo "NetCDF Fortran module:  $modnetcdff"
echo "Jasper module:          $modjasp"
echo "PNG module:             $modpng"
echo "JPEG module             $modjpeg"
echo "Zlib module:            $modz"
echo "Perl module:            $modperl"
echo "HDF5 module:            $modhdf"
echo "M4 module:              $modm4"
echo "Libtool module:         $modlt"

module use --append ~/Source/wrf/deps/spack/share/spack/modules/$spackarch

module load $modopenmpi $modnetcdfp $modnetcdfc $modnetcdff $modjasp $modpng $modz $modperl $modhdf $modm4 $modlt $modjpeg

cd ~/Source/wrf/deps/spack/opt/spack/
spackarch2=$(ls | grep linux-)
cd ~/Source/wrf/deps/spack/opt/spack/$spackarch2
# work out if we are using a spack that inserts the GCC verison.
if [ -d "gcc-${gccver}" ]; then
   spackarch2="${spackarch2}/gcc-${gccver}"
fi
cd gcc-${gccver}

ncdir=$(ls | grep netcdf-fortran-)
nccdir=$(ls | grep netcdf-c-)
jaspdir=$(ls | grep jasper-)
jpegdir=$(ls | grep libjpeg-)

#echo "BRAVELY MERGING NETCDF!!!"
#rsync -av "$HOME/Source/wrf/deps/spack/opt/spack/$spackarch/gcc-9.2.0/$nccdir/" "$HOME/Source/wrf/deps/spack/opt/spack/$spackarch/gcc-9.2.0/$ncdir/"
#rsync -av "$HOME/Source/wrf/deps/spack/opt/spack/$spackarch/gcc-9.2.0/$ncdir/" "$HOME/Source/wrf/deps/spack/opt/spack/$spackarch/gcc-9.2.0/$nccdir/"
#echo "MERGE COMPLETE!!"

export NETCDF="$HOME/Source/wrf/deps/spack/opt/spack/$spackarch2/$ncdir"
export NETCDF_classic=1
export NETCDFF=$NETCDF
export NETCDFC="$HOME/Source/wrf/deps/spack/opt/spack/$spackarch2/$nccdir"
export JASPERLIB="$HOME/Source/wrf/deps/spack/opt/spack/$spackarch2/$jaspdir/lib64"
export JASPERINC="$HOME/Source/wrf/deps/spack/opt/spack/$spackarch2/$jaspdir/include"
export LD_LIBRARY_PATH="$JASPERLIB:$HOME/Source/wrf/deps/spack/opt/spack/$spackarch2/$jpegdir/lib64:$HOME/Source/wrf/deps/spack/opt/spack/$spackarch2/$ncdir/lib:$HOME/Source/wrf/deps/spack/opt/spack/$spackarch2/$nccdir/lib:$LD_LIBRARY_PATH"

cd $oldpwd
