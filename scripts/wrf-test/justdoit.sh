#!/bin/bash

# In theory this should be a one-step build.

set -e

mkdir -p ~/Source/wrf/deps

./build-deps.sh

./wrf-4.3.sh
./wrf-4.4.1.sh
