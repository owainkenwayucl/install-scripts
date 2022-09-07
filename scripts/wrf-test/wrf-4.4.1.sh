#!/usr/bin/env bash

set -e

ln -fs /shared/ucl/apps/build_scripts/includes .

for i in ${includes_dir:=$(dirname $0 2>/dev/null)/includes}/{module_maker,require}_inc.sh; do . $i; done

source environment.sh

NAME=${NAME:-wrf}
VERSION=${VERSION:-4.4.1}
#INSTALL_PREFIX=${INSTALL_PREFIX:-/shared/ucl/apps/$NAME/$VERSION/$COMPILER_TAG}
INSTALL_PREFIX=${INSTALL_PREFIX:-${HOME}/Source/wrf/builds}
GIT_REPO=${GIT_REPO:-https://github.com/wrf-model/WRF/}
SOURCE_ARCHIVE=${SOURCE_ARCHIVE:-https://github.com/wrf-model/WRF/releases/download/v${VERSION}/v${VERSION}.tar.gz}
GIT_BUILD=${GIT_BUILD:-no}
UNLOCK_RANKS=${UNLOCK_RANKS:-no}

orig_dir=$(pwd)

rm -Rf $INSTALL_PREFIX/$VERSION
mkdir -p $INSTALL_PREFIX
cd $INSTALL_PREFIX

if [ "${GIT_BUILD^^}" == "YES" ]; then
   git clone $SRC_ARCHIVE $VERSION
   cd $VERSION
   git checkout v$VERSION

else
   wget $SOURCE_ARCHIVE
   # Note we are https:ing this from the same location as the git repo so no
   # need to checksum.
   tar xvf v${VERSION}.tar.gz
   mv WRFV${VERSION} ${VERSION}
   cd $VERSION
fi

if [ "${UNLOCK_RANKS^^}" == "YES" ]; then
   # Apply Oscar's patch to unlock the rank limits.
   cd share
   cp ${orig_dir}/patches/disable_rank_check.patch .
   patch < disable_rank_check.patch
   cd ..
fi

./configure
./compile -j 4 em_real

