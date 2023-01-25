#!/bin/bash

# This script copies the datapoint.json next to the data, 
# and zips everything for publication. 
# It is meant to be run AFTER the `get-all-datapoints.sh`.
# Your ../data directory must be filled with the bugs. 
# This script is meant to be run from within the tools-directory.

# Comment in for Debug Info
# set -x 

SECONDS=0
REFERENCE_FOLDER=../references
DATA_FOLDER=../data
ZIP_POSTFIX=$(date +'%Y-%m-%d')
ZIP_NAME="hasbugs-${ZIP_POSTFIX}.tar.gz"

echo "Copying the datapoint.json's from ${REFERENCE_FOLDER} to ${DATA_FOLDER}"
for f in `find $REFERENCE_FOLDER -name "datapoint.json" -type f`; do
    if grep -v -q "invalid" <<< "$f"; then
        repo=$(basename $(dirname $(dirname $f)))
        id=$(basename $(dirname $f))

        copy_target="${DATA_FOLDER}/${repo}-${id}/"
        if [ -d "$copy_target" ] 
        then 
            cp $(realpath $f) "${copy_target}${repo}-${id}.json";
        else
            echo "Failed to copy datapoint for ${repo}-${id}";
        fi
    fi
done
echo "Finished Copying Datapoints"

#TODO: Copy README if exists 
#TODO: Copy dataset.json if nearby 

# echo "Zipping data in ${DATA_FOLDER} into ${ZIP_NAME}"
# tar -czf "${ZIP_NAME}" "${DATA_FOLDER}"

# echo "Finished Zipping Data, script took total of $(($SECONDS / 60)) minutes ($SECONDS seconds)"