#!/bin/bash -l


set -e
module purge
module load rcps-core


rm -Rf ~/Source/wrf/deps
mkdir -p ~/Source/wrf/deps
cd ~/Source/wrf/deps

rm -Rf ~/.spack
git clone https://github.com/spack/spack

module load python/3.8.6

cd spack
module use --append $(pwd)/share/spack/modules/linux-rhel7-cascadelake
bin/spack install gcc@11.1.0

bin/spack compiler find

bin/spack install wrf@4.2%gcc@11.1.0

