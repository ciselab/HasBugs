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
if [ ! -z "$display_name" ] && [ -d "$list_dir/$display_name" ]; then
	cd "$list_dir/$display_name"
	. metadata.config
elif [[ ! -d "$list_dir/$display_name" ]]; then
	echo "Cannot find repository with name: $display_name"
	exit 1
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

echo "Will you use a test patch? (true/false)"
read patch_test

echo "What version of GHC is used to compile this bug/fix/test?"
read ghc_version

echo "Describe the bug."
read description

echo "What categories does this bug belong to (separate with ',')?"
IFS="," read -r -a categories

# Trim whitespace from list
for ((i=0; i<"${#categories[@]}"; i++)); do
	categories[$i]=$(echo "${categories[$i]}" | xargs)
done

echo "Link the issue(s) that this fix was applied for (full URLs, separated with ',')."
IFS="," read -r -a issues

# Trim whitespace from list
for ((i=0; i<"${#issues[@]}"; i++)); do
	issues[$i]=$(echo "${issues[$i]}" | xargs)
done

echo "Link the pull request(s) that this fix was applied in (full URLs, separated with ',')."
IFS="," read -r -a prs

# Trim whitespace from list
for ((i=0; i<"${#prs[@]}"; i++)); do
	prs[i]=$(echo "${prs[$i]}" | xargs)
done




## Create the bug directory and output metadata and Dockerfile

# Get and update the id
bug_id=$(cat .bug-id)
full_bug_id="$display_name-$bug_id"

# If the directory already exists, make a report and exit
if [[ -d "$bug_id" ]]; then
	echo "ERROR: Directory for bug $full_bug_id already exists!"
	exit 1
fi

echo "$((bug_id+1))" > .bug-id


# Make the directory
echo -e "\nMaking the bug directory for bug $full_bug_id."
mkdir -p "$bug_id"
cd "$bug_id"

# Output these variables to a config file in the directory
echo "Writing metadata.config file"
cat <<EOF > metadata.config
#!/bin/bash

# Repository 
if [[ ! "\$1" == "norepo" ]]; then
$(cat ../metadata.config | xargs -L 1 echo -e "\t")
fi

# Bug
full_bug_id="$full_bug_id"
bug_id="$bug_id"
fault_commit="$fault_commit"
fix_commit="$fix_commit"
patch_test=$patch_test
ghc_version="$ghc_version"
description="$description"
categories=($(printf "\"%s\" " "${categories[@]}" | rev | cut -c2- | rev))
issues=($(printf "\"%s\" " "${issues[@]}" | rev | cut -c2- | rev))
prs=($(printf "\"%s\" " "${prs[@]}" | rev | cut -c2- | rev))
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


# Write the get-tested.sh script link
echo "Writing run-tested.sh script"
cat <<EOF > run-tested.sh
$(cat .temp.sh)

# Call run-tested.sh script
$(realpath --relative-to="$PWD" "$script_dir")/run-tested.sh "\$display_name" "\$bug_id"
EOF
chmod +x run-tested.sh


rm .temp.sh



# Write the datapoint.json file
echo "Writing datapoint.json file"
cat <<EOF > datapoint.json
{
    "id": "$full_bug_id",
    "repositoryurl": "$repository_url",
    "repository": "$display_name",
    "license": "$license",
    "faultcommit": "$fault_commit",
    "fixcommit": "$fix_commit",
    
    "ghcversion": "$ghc_version",
    "buildframework": "$build_framework",
    "testframeworks": [$(printf "\"%s\", " "${test_frameworks[@]}" | rev | cut -c3- | rev)],

    "testpatch": $patch_test,
    "description": "$description",
    "categories": [$(printf "\"%s\", " "${categories[@]}" | rev | cut -c3- | rev)],
    
    "relatedissues": [$(printf "\"%s\", " "${issues[@]}" | rev | cut -c3- | rev)],
    "relatedprs": [$(printf "\"%s\", " "${prs[@]}" | rev | cut -c3- | rev)],
    
    "faultlocations" : [
    {
        "startline": 5,
        "endline": 15,
        "file" : "./project/.../Module.hs",
        "module" : "Fully.Qualified.Module",
        "function": "main"
    },{
        "startline": 25,
        "endline": 35,
        "file": "./project/.../Module.hs",
        "module": "Fully.Qualified.Module",
        "function": "helper"
    }
    ],
    "fixlocations" : [
    {
        "startline": 5,
        "endline": 20,
        "file": "./project/.../Module.hs",
        "module": "Fully.Qualified.Module",
        "function": "main"
    }
    ]
}
EOF






