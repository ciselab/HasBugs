#!/bin/bash


# Comment in for Debug Info
# set -x 

# Blatantly stolen one-liner to get the directory that this script is located in,
# rather than the location the script is called from.
script_dir=$(cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd)


if [[ -z "$1" ]]; then
	echo "The display name of the repo is required as the first argument!"
	exit 1
fi


if [[ -z "$2" ]]; then
	echo "The ID of the bug to pull is required as the second argument!"
	exit 1
fi


# Whether or not to remove the History
# If true, after moving to the specified commit the .git will be deleted to make the dataset smallet
export remove_history=false

###                                    ###
#       From Here on, it's autopilot     #
#      (but not like the Tesla ones)     #
###                                    ###
"$script_dir/get-repo.sh" "$1" "$2" "tested"

