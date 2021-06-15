#!/bin/bash

# Debug Info
set -x 

bug_id=3
target_directory=../../../data
repository=elki-project/elki
commit=1997614e9a184946bdd66c955660a4e4bc160167

remove_history=false

echo "creating ${target_directory}/${bug_id}"
mkdir "${target_directory}/"
mkdir "${target_directory}/${bug_id}"
mkdir "${target_directory}/${bug_id}/buggy"
cd "${target_directory}/${bug_id}/buggy"

echo "cloning git@github.com:${repository}.git"
git clone "git@github.com:${repository}.git" .

echo "git reset --hard ${commit}" | sh
# Kick out Git History for smaller Dataset
if [ "$remove_history" = true ]; 
then rm -rf .git;
else echo "Keeping Git History for ${repository}"; 
fi

exit 0