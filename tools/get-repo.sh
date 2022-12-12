#!/bin/bash

# Location that the script is called from.
origin="$PWD"

# Blatantly stolen one-liner to get the directory that this script is located in,
# rather than the location the script is called from.
script_dir=$(cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd)

# Set the directory in which the list of bugs is compiled.
list_dir="$script_dir/../references"

# Set the directory in which data is stored
data_dir="$script_dir/../data"

# Set the patch file name
patch_file="HASBUGS_TEST.patch"


# First argument to this script should be the display name of the project repository (as named in the directory structure as well).
display_name="$1"

# Id of the bug to pull the repo for
bug_id="$2"

# Third argument, a name for the target of this script (buggy, fixed, tested usually).
# If none is given, this defaults to "latest", for testing purposes.
target="$3"
if [[ -z "$target" ]]; then
	target="latest"
fi

# If the directory for that repository does not yet exist, exit
if [[ ! -d "$list_dir/$display_name" ]]; then
	echo "Cannot find repository with name '$display_name'"
	exit 1
fi

# Source repository and/or bug informatiregexon
if [[ -z "$bug_id" ]]; then
	. "$list_dir/$display_name/metadata.config"
	docker_file="$list_dir/$display_name/HASBUGS_DOCKERFILE"
else
	. "$list_dir/$display_name/$bug_id/metadata.config"
	docker_file="$list_dir/$display_name/$bug_id/HASBUGS_DOCKERFILE"
fi


# The directory that the repository will be cloned into.
if [[ "$target" == "latest" ]]; then
	target_dir="${data_dir}/${display_name}"
else
	target_dir="${data_dir}/${display_name}-${bug_id}/${target}"
fi


# Create the target directory and move into it.
echo "Creating ${target_dir}"
mkdir -p "$(dirname $target_dir)"
cd "$(dirname $target_dir)"


# Clone the repository into this directory
if [[ ! -d "$target_dir/.git" ]]; then
	rm -rf "$target_dir"
	echo "Cloning $repository_url"
	#TODO: Maybe we can add a "heuristic depth" here, such as the last 50 commits. I think for most bugs that works. 
	#Short Update: I tried with 120, but that failed on Pandoc. Maybe it is necessary to get the whole history. ¯\_(ツ)_/¯
	git clone "$repository_url" "$target_dir"
else
	echo "Already cloned repository"
fi

# Move into the target directory
echo "Going into '$target_dir'"
cd "$target_dir"


# Ensure we're not still in the HasBugs repository
if [[ ! -z "$(git remote show origin | grep HasBugs)" ]]; then
	echo "Still in HasBugs repository! Cannot continue git operations..."
	exit 1
fi

# Print the fix and fault commit
echo "Using faulty commit: $fault_commit"
echo "Using fixed commit: $fix_commit"

# Set HEAD to the given commit if one is given
if [[ "$target" == "buggy" ]]; then
	echo "Resetting to faulty commit: ${fault_commit}"
	git reset --hard
	git checkout -f "$fault_commit"
elif [[ "$target" == "fixed" ]]; then
	echo "Resetting to fixed commit: ${fix_commit}"
	git reset --hard
	git checkout -f "$fix_commit"
elif [[ "$target" == "tested" && "$patch_test" ]]; then
	echo "Resetting to faulty commit and patching with test"
	git reset --hard
	git checkout -f "$fault_commit"

	echo "Patching with patch file: ${patch_file}"
	cp "${origin}/${patch_file}" ./
	git apply "${patch_file}"
elif [[ "$target" == "tested" ]]; then
	echo "Resetting to fixed commit (with test?)"
	git reset --hard
	git checkout -f "$fix_commit"
else
	echo "Not resetting to any commit, using HEAD as it is"
fi


# Remove the Git history if required
if [ "$remove_history" = true ]; then
	echo "Removing Git history for ${repository_name}"
	rm -rf .git
else
	echo "Keeping Git history for ${repository_name}"
fi


# Move the Dockerfile in.
echo "Moving the HasBugs Dockerfile and Dockerignore to project repository"
cp "$docker_file" ./
touch "HASBUGS_DOCKERFILE.dockerignore"

