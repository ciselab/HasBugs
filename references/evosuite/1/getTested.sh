#!/bin/bash


# Comment in for Debug Info
# set -x 

# A running number of the project
bug_id=6
# The repository from which to curl, must match the url from Github
repository=EvoSuite/evosuite
# The commit in which the problem was tested, according to the authors
# If the authors did not provide a test, but the buggy-commit here, and provide a test-patch
commit=a36ed52e65184c03857125e11d9b93dbd812f24f

# Whether or not the project is tested at the given commit
# True means we (Rhodos Maintainers) provide a patch, false means the given commit has failing tests
needs_patch=False
# The file in this folder that contains the patch from buggy->tested
patch_file=testX.patch


target_directory=../../../data
# Whether or not to remove the History
# If true, after moving to the specified commit the .git will be deleted to make the dataset smaller
remove_history=False

###                                    ###
#       From Here on, it's autopilot     #
#      (but not like the Tesla ones)     #
###                                    ###

echo "creating ${target_directory}/${bug_id}"
mkdir "${target_directory}/"
mkdir "${target_directory}/${bug_id}"
mkdir "${target_directory}/${bug_id}/tested"
origin="$PWD"
cd "${target_directory}/${bug_id}/tested"

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

# Put the Rhodos-Dockerfile in Place
echo "moving the Rhodos Dockerfile to project repository"
cp "${origin}/RHODOS_DOCKERFILE" .

exit 0