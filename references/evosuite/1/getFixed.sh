#!/bin/bash

# Comment in for Debug Info
# set -x 

# A running number of the project
bug_id=6
# The repository from which to curl, must match the url from Github
repository=EvoSuite/evosuite
# The commit in which the problem was solved, according to the authors
commit=7ac2b86ef362ea7b3e964202622e3207a6b50fd6


target_directory=../../../data
# Whether or not to remove the History
# If true, after moving to the specified commit the .git will be deleted to make the dataset smaller
remove_history=False

###                              ###
# From Here on, it's autopilot     #
###                              ###

origin="$PWD"

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

# Put the Rhodos-Dockerfile in Place
echo "moving the Rhodos Dockerfile to project repository"
cp "${origin}/RHODOS_DOCKERFILE" .

exit 0