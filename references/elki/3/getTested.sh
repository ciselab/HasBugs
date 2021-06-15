#!/bin/bash

# Debug Info
set -x 

needs_patch=true 

patch_file=test3.patch

bug_id=3
target_directory=../../../data
repository=elki-project/elki
commit=497fc7aef2b7f5cda0f6ef2ed620b4a937490b62

remove_history=false

# Happy Path: if the commit is known to be tested
# Just check it out. 

echo "creating ${target_directory}/${bug_id}"
mkdir "${target_directory}/"
mkdir "${target_directory}/${bug_id}"
mkdir "${target_directory}/${bug_id}/tested"
origin="$PWD"
cd "${target_directory}/${bug_id}/tested"

# Problem: It doesn't want to copy into a 
echo "cloning git@github.com:${repository}.git"
git clone "git@github.com:${repository}.git" .

if [[ "$needs_patch" = true ]]; 
then cp "${origin}/${patch_file}" . ;
else echo "No patch required for this commit - (failing) tests are included"
fi

# Move to the buggy commit
echo "git reset --hard ${commit}" | sh

# I had a default signing on, which prompted when running the git am later
git config commit.gpgsign false

# If there is no test in the specified commit, 
# Then we have to perform a patch
if [[ "$needs_patch" = true ]]; 
then echo "git am ${patch_file}" | sh ;
fi

# Kick out Git History for a smaller Dataset
if [ "$remove_history" = true ]; 
then rm -rf .git;
else echo "Keeping Git History for ${repository}"; 
fi

exit 0