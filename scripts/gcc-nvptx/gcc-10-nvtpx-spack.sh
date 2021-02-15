#!/usr/bin/env bash

###############################################
# Installing 
#
# by Owain Kenway, 2018
#
set -e

ln -fs /shared/ucl/apps/build_scripts/includes .


for i in ${includes_dir:=$(dirname $0 2>/dev/null)/includes}/{module_maker,require}_inc.sh; do . $i; done

require gcc-libs/4.9.2

NAME=${NAME:-gcc-nv-10}
VERSION=${VERSION:-spack}
INSTALL_PREFIX=${INSTALL_PREFIX:-$HOME/Applications/$NAME}

SRC_ARCHIVE=${SRC_ARCHIVE:-https://github.com/owainkenwayucl/spack}

rm -rf $INSTALL_PREFIX
mkdir -p $INSTALL_PREFIX
cd $INSTALL_PREFIX

git clone $SRC_ARCHIVE
cd spack
#git checkout flang-libstdc++fix-pullrequest

restorecompilers=no
if [ -f $HOME/.spack/linux/compilers.yaml ]; then
  echo ">>> Backing up compilers.yaml..."
  mv $HOME/.spack/linux/compilers.yaml $HOME/.spack/linux/compilers.yaml.bak
  restorecompilers=yes
fi

cd bin
./spack install gcc@10.2+nvptx
cd ..

if [ "$restorecompilers" = "yes" ]; then
  echo ">>> Restoring compilers.yaml..."
  mv $HOME/.spack/linux/compilers.yaml.bak $HOME/.spack/linux/compilers.yaml
fi
echo ">>> Cleaning up staging area..."
cd $INSTALL_PREFIX/spack/bin
./spack clean

