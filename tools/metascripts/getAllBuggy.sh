#!/bin/bash

# This script runs over all the references and invokes "getBuggy.sh"

# Comment in for Debug Info
set -x 

REFERENCE_FOLDER="../../references"

pivot="$PWD"

find ../../references -name '*/getBuggy.sh' -printf "%h\n" | sort -u
folders=$(find ../../references -type f -name '*getBuggy.sh'| sed 's#/[^/]*$##'  | sort -u)

for f in $folders;
do 
    echo "Running GetBuggy in ${f}";
    cd $f 
    sh getBuggy.sh
    cd $pivot
done

#Problem: The Dockerfile is search for next to this
#find "${REFERENCE_FOLDER}" -name 'getBuggy.sh' -exec sh {} \;
