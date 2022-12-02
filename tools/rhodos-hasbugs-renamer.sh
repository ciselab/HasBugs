# !/bin/bash

# Renames from Rhodos to HasBugs in DockerFiles and DockerFiles.dockerignore
find . -name RHODOS_DOCKERFILE  | xargs -I {} bash -c 'git mv {} $(dirname {})/HASBUGS_DOCKERFILE'
find . -name RHODOS_DOCKERFILE.dockerignore  | xargs -I {} bash -c 'git mv {} $(dirname {})/HASBUGS_DOCKERFILE.dockerignore'
