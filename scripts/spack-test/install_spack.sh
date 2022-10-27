#!/bin/bash

set -e
source /etc/profile.d/modules.sh
module purge

source scl_source enable rh-python38 devtoolset-11

cd ~/Applications
rm -Rf ~/Applications/spack
rm -Rf ~/.spack
git clone https://github.com/spack/spack

cd spack
bin/spack install python@3.10.7

arch=`ls share/spack/modules/linux-rhel7*`

ln -s `pwd`/$arch `pwd`/share/spack/modules/ucl-linux
