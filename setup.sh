#!/bin/bash

# Blatantly stolen one-liner to get the directory that this script is located in,
# rather than the location the script is called from.
script_dir="$(cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd)/tools"

# Create aliases for the script directory scripts
alias cleanup-all="$script_dir/cleanup.sh"
alias commit-analysis="$script_dir/commit-analysis.sh"
alias create-repo="$script_dir/create-repo.sh"
alias create-bug="$script_dir/create-bug.sh"
alias get-buggy="$script_dir/get-buggy.sh"
alias get-fixed="$script_dir/get-fixed.sh"
alias get-tested="$script_dir/get-tested.sh"
alias get-repo="$script_dir/get-repo.sh"

