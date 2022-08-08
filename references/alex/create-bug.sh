#!/bin/bash

# Blatantly stolen one-liner to get the directory that this script is located in,
# rather than the location the script is called from.
repo_dir=$(cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd)

# Get the (current) display name from the repo directory name.
display_name=$(basename $repo_dir)

# Move into repo directory for the relative link later
cd $repo_dir

# Call the create-bug.sh script from this location
../../scripts/create-bug.sh "$display_name"
