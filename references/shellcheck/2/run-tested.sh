#!/bin/bash

# Blatantly stolen one-liner to get the directory that this script is located in,
# rather than the location the script is called from.
bug_dir=$(cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd)

# Get the bug id and the repository display name
bug_id=$(basename $bug_dir)
display_name=$(basename $(dirname $bug_dir))

# Set working directory to relatively link to the scripts
cd $bug_dir

# Call run-tested.sh script
./run-tested.sh "$display_name" "$bug_id"
