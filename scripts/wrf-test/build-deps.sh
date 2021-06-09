#!/bin/bash -l


set -e
module purge
module load rcps-core
module load python/3.8.6
module load compilers/gnu/9.2.0

rm -Rf ~/Source/wrf/deps
mkdir -p ~/Source/wrf/deps
cd ~/Source/wrf/deps

rm -Rf ~/.spack
git clone https://github.com/spack/spack


cd spack
bin/spack install wrf@4.2

