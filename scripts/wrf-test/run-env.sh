#!/bin/bash -l

set -e

source environment.sh

export PATH="$HOME/Source/wps/builds/4.4/ungrib:$HOME/Source/wps/builds/4.4:$HOME/Source/wrf/builds/4.4.1/run:$HOME/Source/wps/builds/4.4/util:$PATH"

set +e
