#!/bin/bash

# This script is meant to build all existing bugs and their buggy, tested and fixed versions. 
# You are meant to have the data pulled beforehand! 
# Check the nearby shell files how to fill your data repository.

script_dir=$(cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd)

SECONDS=0
DATA_FOLDER=../data
# TODO: Sanity Check for ./data to exist
if [ -d "$DATA_FOLDER" ]; then
    echo "Starting to build all Dockerfiles found in $DATA_FOLDER"
else
   echo "Warning: '$DATA_FOLDER' NOT found. Run other scripts first!"
   exit 1
fi
# TODO: Run over all datapoints in data 
# Extract the path from these datapoints
# Filter out ones that have "invalid" in there

# Extract the path from these datapoints
for d in `find $DATA_FOLDER -name "HASBUGS_DOCKERFILE" -type f`; do    
    cd $script_dir
    state=$(basename $(dirname $d))
    id=$(basename $(dirname $(dirname $d)))
    dir=$(dirname $d)
    echo -e "Found Dockerfile for $id:$version \t $state \t at  $d"

    # Move to the directory, to properly do docker 
    cd $dir 

    version=$(cat .hasbugs_version)
    image_name=$(echo "ghcr.io/ciselab/hasbugs/$id:$state-$version")
    start_image_build=$SECONDS
    # Starting Docker build 
    docker build -f HASBUGS_DOCKERFILE . -t $image_name

    duration=$(($SECONDS - $start_image_build))
    echo "building $image_name took $duration seconds( $(($duration / 60)) minutes)"
done

echo "Building all Docker-Images took $(($SECONDS / 60)) minutes ($SECONDS seconds)"