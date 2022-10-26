#!/bin/bash -l


set -e
module purge
module load gcc-libs/4.9.2
module load compilers/gnu/4.9.2
modile load python/3.9.10

cd ~/Applications
rm -Rf ~/Applications/spack
rm -Rf ~/.spack
git clone https://github.com/spack/spack

cd spack
bin/spack install python@3.11.0

arch=`ls share/spack/modules/linux-rhel7*`

ln -s `pwd`/$arch share/spack/modules/ucl-linux
