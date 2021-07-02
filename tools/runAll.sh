#!/bin/bash

# This script runs over all the datapoints and builds the Dockerfile
# The Dockerfile should go red or green according to the build status.

# Comment in for Debug Info
#set -x 

DATA_FOLDER="../data"

pivot="$PWD"

folders=$(find ${DATA_FOLDER} -type f -name '*RHODOS_DOCKERFILE'| sed 's#/[^/]*$##'  | sort -u)

for f in $folders;
do 
    echo "Running RHODOS_DOCKERFILE in ${f}";
    cd $f
    docker build . --progress=plain -f RHODOS_DOCKERFILE | tee RHODOS.log;
    cd $pivot
done