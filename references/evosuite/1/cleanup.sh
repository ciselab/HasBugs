#!/bin/bash
# Removes all resources downloaded/copied for ID X

# Comment in for Debug Info
# set -x 

bug_id=6
target_directory=../../../data

rm -rf "${target_directory}/${bug_id}"