# !/bin/bash

# Renames from Rhodos to HasBugs in DockerFiles and DockerFiles.dockerignore
find . -name RHODOS_DOCKERFILE  | xargs -I {} bash -c 'git mv {} $(dirname {})/HASBUGS_DOCKERFILE'
find . -name RHODOS_DOCKERFILE.dockerignore  | xargs -I {} bash -c 'git mv {} $(dirname {})/HASBUGS_DOCKERFILE.dockerignore'
# Rename Test-Patches 
find . -name RHODOS_TEST.patch  | xargs -I {} bash -c 'git mv {} $(dirname {})/HASBUGS_TEST.patch'
