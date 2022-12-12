#!/bin/bash

# Blatantly stolen one-liner to get the directory that this script is located in,
# rather than the location the script is called from.
script_dir=$(cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd)

# Set the directory in which data is stored
data_dir="$script_dir/../data"

echo "Running Cleanup for HasBugs $data_dir folder"
# Remove all contents of the data directory
rm -vrf "$data_dir"

mkdir "$data_dir"

#TODO: Delete all related docker images

echo "Finished HasBugs Cleanup"