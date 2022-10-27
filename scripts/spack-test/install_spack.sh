#!/bin/bash

set -e
source /etc/profile.d/modules.sh
module purge

# This should work but exits non-zero
# source scl_source enable rh-python38 devtoolset-11

UCL_SCLS="rh-python38 devtoolset-11"

for a in ${UCL_SCLS}
do
   source /opt/rh/${a}/enable
done
export X_SCLS="${UCL_SCLS} ${X_SCLS}"



cd ~/Applications
rm -Rf ~/Applications/spack
rm -Rf ~/.spack
git clone https://github.com/spack/spack

cd spack
bin/spack install python@3.10.7

arch=`ls share/spack/modules| grep linux-rhel`

ln -s `pwd`/share/spack/modules/${arch} `pwd`/share/spack/modules/ucl-linux
