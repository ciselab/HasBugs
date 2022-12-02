#!/bin/bash

# Blatantly stolen one-liner to get the directory that this script is located in,
# rather than the location the script is called from.
script_dir=$(cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd)

# Set the directory in which data is stored
data_dir="$script_dir/../data"

# Display name of the repository to pull
display_name="$1"


# Fetch the repository
"$script_dir/get-repo.sh" "$display_name"

# Create a log file
cd "$data_dir/$display_name"
git log > hasbugs.gitlog

echo ""

# Count occurrences of issue-like text
echo "Counting $(grep -Eo "#" hasbugs.gitlog | wc -l) #'s"
echo "Counting $(grep -Eo "#[0-9]{1,5}[^0-9]" hasbugs.gitlog | wc -l) #'s with digits"
echo "Counting $(grep -Eo "!" hasbugs.gitlog | wc -l) !'s"
echo "Counting $(grep -Eo "![0-9]{1,5}[^0-9]" hasbugs.gitlog | wc -l) !'s with digits"

