#/usr/bin/scl enable rh-python38 devtoolset-11 bash

set -e
module purge

cd ~/Applications
rm -Rf ~/Applications/spack
rm -Rf ~/.spack
git clone https://github.com/spack/spack

cd spack
bin/spack install python@3.10.7

arch=`ls share/spack/modules/linux-rhel7*`

ln -s `pwd`/$arch share/spack/modules/ucl-linux
