#!/bin/bash -l


set -e

gccver=${gccver:-9.2.0}
wrfver=${wrfver:-4.2}
ompiver=${ompiver:-4}
module purge
module load beta-modules
module load gcc-libs/${gccver}
module load python/3.9.10
module load compilers/gnu/${gccver}
module load git

rm -Rf ~/Source/wrf/deps
mkdir -p ~/Source/wrf/deps
cd ~/Source/wrf/deps

rm -Rf ~/.spack
git clone https://github.com/spack/spack


cd spack
git checkout v0.23.1

bin/spack config add "modules:default:enable:[tcl]"
bin/spack install wrf@${wrfver} openmpi@${ompiver}


oldpwd=$(pwd)
cd ~/Source/wrf/deps/spack/opt/spack/
spackarch=$(ls | grep linux-)
cd ~/Source/wrf/deps/spack/opt/spack/$spackarch
# work out if we are using a spack that inserts the GCC verison.
if [ -d "gcc-${gccver}" ]; then
   spackarch="${spackarch}/gcc-${gccver}"
fi
cd gcc-${gccver}
ncdir=$(ls | grep netcdf-fortran-)
nccdir=$(ls | grep netcdf-c-)

echo "BRAVELY MERGING NETCDF!!!"
rsync -av "$HOME/Source/wrf/deps/spack/opt/spack/$spackarch/$nccdir/" "$HOME/Source/wrf/deps/spack/opt/spack/$spackarch/$ncdir/"
rsync -av "$HOME/Source/wrf/deps/spack/opt/spack/$spackarch/$ncdir/" "$HOME/Source/wrf/deps/spack/opt/spack/$spackarch/$nccdir/"
echo "MERGE COMPLETE!!"
