#!/bin/bash -l


set -e
module purge
module load beta-modules
module load gcc-libs/9.2.0
module load python/3.9.10
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
cd ~/Source/wrf/deps/spack/opt/spack/
spackarch=$(ls | grep linux-)
cd $spackarch
ncdir=$(ls | grep netcdf-fortran-)
nccdir=$(ls | grep netcdf-c-)

echo "BRAVELY MERGING NETCDF!!!"
rsync -av "$HOME/Source/wrf/deps/spack/opt/spack/$spackarch/$nccdir/" "$HOME/Source/wrf/deps/spack/opt/spack/$spackarch/$ncdir/"
rsync -av "$HOME/Source/wrf/deps/spack/opt/spack/$spackarch/$ncdir/" "$HOME/Source/wrf/deps/spack/opt/spack/$spackarch/$nccdir/"
echo "MERGE COMPLETE!!"
