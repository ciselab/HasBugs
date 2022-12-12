#!/bin/bash

# This script pulls the data for all given datapoints and runs their respective 
# Shell scripts.

shopt -s nullglob

REFERENCE_FOLDER=../references

# Extract the path from these datapoints
for f in `find $REFERENCE_FOLDER -name "datapoint.json" -type f`; do
    # Filter out ones that have "invalid" in there
    if grep -v -q "invalid" <<< "$f"; then
    # for each valid datapoint, do "get-buggy","get-tested" and "get-fixed"
        echo "Catching Buggy, Tested and Fixed for $f"

        local_directory=$(dirname $f)
        bash "$local_directory/get-buggy.sh"
        bash "$local_directory/get-tested.sh"
        bash "$local_directory/get-fixed.sh"
    fi
done