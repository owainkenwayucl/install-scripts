#!/bin/bash -l


set -e
module purge
module load beta-modules
module load gcc-libs/9.2.0
module load python/3.8.6
module load compilers/gnu/9.2.0

rm -Rf ~/Source/wrf/deps
mkdir -p ~/Source/wrf/deps
cd ~/Source/wrf/deps

rm -Rf ~/.spack
git clone https://github.com/spack/spack


cd spack

bin/spack config add "modules:default:enable:[tcl]"
bin/spack install wrf@4.2


oldpwd=$(pwd)
cd ~/Source/wrf/deps/spack/share/spack/modules
spackarch=$(ls | grep linux-)

cd ~/Source/wrf/deps/spack/opt/spack/$spackarch
ncdir=$(ls | grep netcdf-fortran-)
nccdir=$(ls | grep netcdf-c-)

echo "BRAVELY MERGING NETCDF!!!"
rsync -av "$HOME/Source/wrf/deps/spack/opt/spack/$spackarch/gcc-9.2.0/$nccdir/" "$HOME/Source/wrf/deps/spack/opt/spack/$spackarch/gcc-9.2.0/$ncdir/"
rsync -av "$HOME/Source/wrf/deps/spack/opt/spack/$spackarch/gcc-9.2.0/$ncdir/" "$HOME/Source/wrf/deps/spack/opt/spack/$spackarch/gcc-9.2.0/$nccdir/"
echo "MERGE COMPLETE!!"


