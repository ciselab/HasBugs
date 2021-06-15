#!/bin/bash

# Debug Info
set -x 

bug_id=5
target_directory=../../../data
repository=elki-project/elki
commit=497fc7aef2b7f5cda0f6ef2ed620b4a937490b62

remove_history=false

echo "creating ${target_directory}/${bug_id}"
mkdir "${target_directory}/"
mkdir "${target_directory}/${bug_id}"
mkdir "${target_directory}/${bug_id}/fixed"
cd "${target_directory}/${bug_id}/fixed"

echo "cloning git@github.com:${repository}.git"
git clone "git@github.com:${repository}.git" .

echo "git reset --hard ${commit}" | sh
# Kick out Git History for smaller Dataset
if [ "$remove_history" = true ]; 
then rm -rf .git;
else echo "Keeping Git History for ${repository}"; 
fi

exit 0