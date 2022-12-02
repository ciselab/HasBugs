#!/bin/bash

# Blatantly stolen one-liner to get the directory that this script is located in,
# rather than the location the script is called from.
script_dir=$(cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd)

# Set the directory in which the list of bugs is compiled.
list_dir="$script_dir/../references"

# Set the directory in which the Dockerfile collection is stored.
docker_dir="$script_dir/../docker"


# Make sure a repository id is setup, and set it up if not
if [[ ! -f "$list_dir/.repo-id" ]]; then
	echo "1" > "$list_dir/.repo-id"
fi


## Ask for a bunch of details on the repository for creating the entry
echo "Enter a simple display name of the project: "
read display_name

echo "The project repository is found under: https://github.com/" 
read repository_name

echo "What license is the project under? " 
read license

echo "What build framework is used for this project? " 
read build_framework

echo "What testing frameworks are used for this project? (separate with comma's)"
IFS="," read -r -a test_frameworks

# Trim whitespace from list
for ((i=0; i<"${#test_frameworks[@]}"; i++)); do
	test_frameworks[$i]=$(echo "${test_frameworks[$i]}" | xargs)
done

# Ask for a dockerfile to reference if one is available for this project
echo "Dockerfiles available:"
ls -l "$docker_dir"

echo "What Dockerfile do you want to use? (leave empty if custom) "
read docker_file

if [ ! $docker_file == *.Dockerfile ]; then
	suffixed_docker_file="$docker_file.Dockerfile"
else
	suffixed_docker_file="$docker_file"
fi


## Create the directory and output metadata and Dockerfile.

# Get and update the id
repository_id=$(cat "$list_dir/.repo-id")
echo "$((repository_id+1))" > "$list_dir/.repo-id"

# Make the directory
echo -e "\nMaking the repository directory for repository $repository_id."
mkdir -p "$list_dir/$display_name"
cd "$list_dir/$display_name"

# Output these variables to a config file in the directory
echo "Writing metadata.config file"
cat <<EOF > metadata.config
#!/bin/bash

repository_id="$repository_id"
display_name="$display_name"
repository_name="$repository_name"
repository_url="git@github.com:$repository_name"
license="$license"
build_framework="$build_framework"
test_frameworks=($(printf "\"%s\" " ${test_frameworks[@]} | rev | cut -c2- | rev))
EOF

# Copy the Dockerfile to the directory if one is provided, or create an empty one
if [ -z $docker_file ]; then
	echo "Writing an empty Dockerfile to directory"
	touch HASBUGS_DOCKERFILE
else
	echo "Copying Dockerfile '$suffixed_docker_file' into directory"
	cp "$docker_dir/$suffixed_docker_file" ./HASBUGS_DOCKERFILE
fi



## Create the scripts that can be used from this directory to further progress

cat <<EOF > /tmp/temp.sh
#!/bin/bash

# Blatantly stolen one-liner to get the directory that this script is located in,
# rather than the location the script is called from.
repo_dir=\$(cd -- "\$( dirname -- "\${BASH_SOURCE[0]}" )" &> /dev/null && pwd)

# Get the (current) display name from the repo directory name.
display_name=\$(basename \$repo_dir)

# Move into repo directory for the relative link later
cd \$repo_dir
EOF

# Create the create-bug.sh script that calls the more complete create-bug.sh script in the scripts directory
echo "Writing create-bug.sh script"
cat <<EOF > create-bug.sh
$(cat /tmp/temp.sh)

# Call the create-bug.sh script from this location
$(realpath --relative-to="$PWD" "$script_dir")/create-bug.sh "\$display_name"
EOF
chmod +x create-bug.sh


# Create the get-project.sh script that calls the more complete get-project.sh scripts in the scripts directory
echo "Writing get-repo.sh script"
cat <<EOF > get-repo.sh
$(cat /tmp/temp.sh)

# Call the get-repo.sh script from this location
$(realpath --relative-to="$PWD" "$script_dir")/get-repo.sh "\$display_name"
EOF
chmod +x get-repo.sh


# If no bug-id file exists yet, create it and initialize with 1
if [[ ! -f ".bug-id" ]]; then
	echo "1" > .bug-id
fi

