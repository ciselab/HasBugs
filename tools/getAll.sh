#!/bin/bash

# This script runs over all the references and invokes "getBuggy.sh","getTested.sh","getFixed.sh" respectively

# Comment in for Debug Info
#set -x 

REFERENCE_FOLDER="../references"

fixies=true
buggies=true
testies=true


pivot="$PWD"

#I check for repositories by only looking for getBuggy - every bug needs to have this
#Short description: Find finds the files, the paths are trunkated using sed to the containing folder, sort -u makes them unique
folders=$(find ${REFERENCE_FOLDER} -type f -name '*getBuggy.sh'| sed 's#/[^/]*$##'  | sort -u)

for f in $folders;
do 
    echo "Running shellfiles in ${f}";
    cd $f
    if [ "$buggies" = true ]; 
    then sh getBuggy.sh;
    else echo "Not getting Buggy Version of ${f}"; 
    fi
    if [ "$testies" = true ]; 
    then sh getTested.sh;
    else echo "Not getting Tested Version of ${f}"; 
    fi
    if [ "$fixies" = true ]; 
    then sh getFixed.sh;
    else echo "Not getting Fixed Version of ${f}"; 
    fi
    cd $pivot
done

