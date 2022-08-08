#!/bin/bash

# Blatantly stolen one-liner to get the directory that this script is located in,
# rather than the location the script is called from.
script_dir=$(cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd)

# Set the directory in which the list of bugs is compiled.
list_dir="$script_dir/../references"

# Set the directory in which the Dockerfile collection is stored.
docker_dir="$script_dir/../docker"



# The first argument is required to be the display_name of the project.
display_name="$1"
if [[ ! -z "$display_name" ]]; then
	cd "$list_dir/$display_name"
	. metadata.config
else
	echo "Missing argument: display name of the repository"
	exit 1
fi

# This script expects to have the following variables made available from any metadata config:
# repository_id
# display_name
# repository_name
# repository_url
# license
# build_framework
# test_frameworks

# Furthermore, this script must be called from the target directory (with metadata already sourced) or it must be called with the name of the repository entered.


# Create the bug-id if one is necessary to be created
if [[ ! -f .bug-id ]]; then
	echo "1" > .bug-id
fi


## Ask for a bunch of details on the bug for creating the entry
echo "Enter the commit at which the fault was apparent." 
read fault_commit

echo "Enter the commit at which the fix was implemented." 
read fix_commit

echo "Enter the commit at which the fix was tested."
read test_commit

echo "Link the issue(s) that this fix was applied for (full URLs, separated with ',')."
IFS="," read issues

echo "Link the pull request(s) that this fix was applied in (full URLs, separated with ',')."
IFS="," read pull_requests


## Create the bug directory and output metadata and Dockerfile

# Get and update the id
bug_id=$(cat .bug-id)
full_bug_if="$display_name-$bug_id"

# If the directory already exists, make a report and exit
if [[ -d "$bug_id" ]]; then
	echo "ERROR: Directory for bug $repository_id-$bug_id already exists!"
	exit 1
fi

echo "$((bug_id+1))" > .bug-id


# Make the directory
echo -e "\nMaking the bug directory for bug $repository_id-$bug_id."
mkdir -p "$bug_id"
cd "$bug_id"

# Output these variables to a config file in the directory
echo "Writing metadata.config file"
cat <<EOF > metadata.config
# Repository 
if [[ ! "\$1" == "norepo" ]]; then
	$(cat ../metadata.config)
fi

full_bug_id=$full_bug_id
bug_id=$bug_id
fault_commit=$fault_commit
fix_commit=$fix_commit
test_commit=$test_commit
issues=$issues
pull_requests=$pull_requests
EOF

# Copy the Dockerfile over
echo "Copying Dockerfile into bug directory"
cp ../RHODOS_DOCKERFILE RHODOS_DOCKERFILE



## Create the scripts that can be used from this directory to get specific instantiations of the repository
cat <<EOF > .temp.sh
#!/bin/bash

# Blatantly stolen one-liner to get the directory that this script is located in,
# rather than the location the script is called from.
bug_dir=\$(cd -- "\$( dirname -- "\${BASH_SOURCE[0]}" )" &> /dev/null && pwd)

# Get the bug id and the repository display name
bug_id=\$(basename \$bug_dir)
display_name=\$(basename \$(dirname \$bug_dir))

# Set working directory to relatively link to the scripts
cd \$bug_dir
EOF

# Write the get-buggy.sh script link
echo "Writing get-buggy.sh script"
cat <<EOF > get-buggy.sh
$(cat .temp.sh)

# Call get-buggy.sh script
$(realpath --relative-to="$PWD" "$script_dir")/get-buggy.sh "\$display_name" "\$bug_id"
EOF
chmod +x get-buggy.sh


# Write the get-fixed.sh script link
echo "Writing get-fixed.sh script"
cat <<EOF > get-fixed.sh
$(cat .temp.sh)

# Call get-fixed.sh script
$(realpath --relative-to="$PWD" "$script_dir")/get-fixed.sh "\$display_name" "\$bug_id"
EOF
chmod +x get-fixed.sh


# Write the get-tested.sh script link
echo "Writing get-tested.sh script"
cat <<EOF > get-tested.sh
$(cat .temp.sh)

# Call get-tested.sh script
$(realpath --relative-to="$PWD" "$script_dir")/get-tested.sh "\$display_name" "\$bug_id"
EOF
chmod +x get-tested.sh








