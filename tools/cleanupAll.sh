#!/bin/bash

# This script runs over all the references and invokes "cleanup.sh"
# I did intentionally not just rm -rf data, 
# Because I thought maybe I end up with more complex cleanups, or the output moves. Who knows what the future brings. 

# Comment in for Debug Info
#set -x 

REFERENCE_FOLDER="../references"

pivot="$PWD"

folders=$(find ${REFERENCE_FOLDER} -type f -name '*cleanup.sh'| sed 's#/[^/]*$##'  | sort -u)

for f in $folders;
do 
    echo "Running cleanup in ${f}";
    cd $f
    sh cleanup.sh;
    cd $pivot
done