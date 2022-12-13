#!/bin/bash

# This script pulls the data for all given datapoints and runs their respective 
# Shell scripts.

shopt -s nullglob
SECONDS=0
REFERENCE_FOLDER=../references

echo "Getting all datapoints for the HasBugs dataset"

# Extract the path from these datapoints
for f in `find $REFERENCE_FOLDER -name "datapoint.json" -type f`; do
    start_repo=$SECONDS
    # Filter out ones that have "invalid" in there
    if grep -v -q "invalid" <<< "$f"; then
    # for each valid datapoint, do "get-buggy","get-tested" and "get-fixed"
        echo "Catching Buggy, Tested and Fixed for $f"
        start_stopwatch=$SECONDS
        local_directory=$(dirname $f)
        bash "$local_directory/get-buggy.sh"
        duration=$(($SECONDS - $start_stopwatch))
        echo "getting $local_directory buggy took $duration seconds( $(($duration / 60)) minutes)"
        start_stopwatch=$SECONDS
        bash "$local_directory/get-tested.sh"
        duration=$(($SECONDS - $start_stopwatch))
        echo "getting $local_directory tested took $duration seconds( $(($duration / 60)) minutes)"
        start_stopwatch=$SECONDS
        bash "$local_directory/get-fixed.sh"
        duration=$(($SECONDS - $start_stopwatch))
        echo "getting $local_directory fixed took $duration seconds ( $(($duration / 60)) minutes)"
    fi
    duration=$(($SECONDS - $start_repo))
    echo "getting $local_directory (all) took $duration seconds  ( $(($duration / 60)) minutes)"
done
echo "getting all repos took $SECONDS seconds ( $(($SECONDS / 60)) minutes)"