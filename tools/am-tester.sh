#!/bin/bash

# Comment in for Debug Info
# set -x 

# Blatantly stolen one-liner to get the directory that this script is located in,
# rather than the location the script is called from.
script_dir=$(cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd)

# Directories
data_dir="$script_dir/../data"
ref_dir="$script_dir/../references"

# Remove the data directories
rm -rf $data_dir/**/tested

function test_am {
	echo $1
	$1 2>&1 | grep "failed"
}

testeds=$(find $ref_dir -name "get-tested.sh")

for tested in $testeds
do
	test_am $tested
done


