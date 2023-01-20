# Notes on ShellCheck

One Build on my macbook: 5 minutes 

Does not specify a GHC Version, but seems to be ok with any modern ones.

Shell Check uses QuickCheck, but expresses many things basically as unit tests (no use of data generation).

## Issue with Builds 

There was an issue that the .dockerignore was not picked up on the server. 
to solve this, the Docker_buildkit must be enabled. 
You can do so by prefixing your docker command with:

```
DOCKER_BUILDKIT=1
```

On Docker Desktop it is default on. But on our linux servers not. 
It should be addressed in the toplevel scripts when building all docker containers. 