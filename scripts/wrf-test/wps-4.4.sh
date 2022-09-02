#!/usr/bin/env bash

set -e

ln -fs /shared/ucl/apps/build_scripts/includes .

for i in ${includes_dir:=$(dirname $0 2>/dev/null)/includes}/{module_maker,require}_inc.sh; do . $i; done

source environment.sh

NAME=${NAME:-wps}
VERSION=${VERSION:-4.4}
#INSTALL_PREFIX=${INSTALL_PREFIX:-/shared/ucl/apps/$NAME/$VERSION/$COMPILER_TAG}
INSTALL_PREFIX=${INSTALL_PREFIX:-${HOME}/Source/wps/builds}
SRC_ARCHIVE=${SRC_ARCHIVE:-https://github.com/wrf-model/WPS/}

rm -Rf $INSTALL_PREFIX/$VERSION
mkdir -p $INSTALL_PREFIX

cd $INSTALL_PREFIX
git clone $SRC_ARCHIVE $VERSION
cd $VERSION
git checkout v$VERSION

./configure
./compile 

