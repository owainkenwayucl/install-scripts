#!/bin/bash

# In theory this should be a one-step build.

set -e

GIT_BUILD=${GIT_BUILD:-no}
UNLOCK_RANKS=${UNLOCK_RANKS:-no}

mkdir -p ~/Source/wrf/deps
mkdir -p ~/Source/wps/builds

./build-deps.sh

#./wrf-4.3.sh
GIT_BUILD=${GIT_BUILD} UNLOCK_RANKS=${UNLOCK_RANKS} ./wrf-4.4.1.sh

ln -s $HOME/Source/wrf/builds/4.4.1 $HOME/Source/wps/builds/WRF

./wps-4.4.sh
