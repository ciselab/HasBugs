## Model
We will store per-project information and per-bug information somewhat separately.
By modeling the project first, then modeling the bug information, we can save some
repetition in creating scripts and datapoints.

### Project information
##### Project ID
Automatically numbered ID for the repository.
Used to ID the bug by its repository and own automatically numbered ID.

##### Repository URL
A clonable link to the repository. Most, if not all, of these will be github URLs.

Example: https://github.com/ciselab/HasBugs

##### License
The license used by the repository at the moment of registering the bug.

Example: MIT

##### Build framework
The framework used to build the project.

##### Test frameworks
The frameworks used to test the project.

### Bug information
##### Bug ID
Automatically numbered ID for the bug.

##### Image
The (Docker) image used to build and run the project after cloning.
This can just be a name. For instance, we expect most Stack-based projects to simply be a case of `stack test` with Stack and some specific version of GHC pre-installed.

Example: stack-9.2.2

##### Fault commit
A commit before the bug was fixed, not per se introduced.
It is hard to pinpoint where the bug was exactly introduced, so we will take the latest commit before a fix was implemented and merged.

##### Fix commit
The last commit that completed the fix.
A diff between the fault commit and fix commit should reflect a complete fix of the bug.

##### Issue(s)
The issues that are related to this bugfix.

##### PR(s)
The PRs that are related to this bugfix.


## Single datapoint
For every bug, we generate a single `datapoint.json` file that contains all info noted above.
However, it specifically combines the project ID and bug ID into a single hyphenated ID.

## Data collecting process
Data is expected to be stored as follows:
docker/
    stack-9.2.2.Dockerfile
    stack-8.0.2.Dockerfile
    ...
{list-dir}/
    {project-name-1}/
        create-bug.sh
        Dockerfile
        (get-project.sh)
        metadata.config
        1/
            datapoint.json
            Dockerfile
            (get-buggy.sh)
            (get-fixed.sh)
            (get-tested.sh)
            metadata.config
        2/
            ...
        3/
            ...
        ...
    ...


1. Inspect a project and note down information
2. Run project setup script and input all project information. It will create:
   * A data directory for the project. (`{list-dir}/{project-name}`)
   * A dockerfile if one cannot be copied from more general Dockerfiles. (under `{list-dir}/{project-name}/HASBUGS_DOCKERFILE`)
   * A `metadata.config` file containing the project information.
   * An executable `create-bug.sh` file to create a new bug datapoint for that project.
   
   Perhaps, the following will no longer be necessary by using the `metadata.config` file to configure scripts.
   * An executable `get-project.sh` file to clone the project.
3. Find a bug and note down information
4. Run bug setup script and input all bug information. It will create:
   * A data directory for the bug. (`{list-dir}/{project-name}/{bug-id}`)
   * A `datapoint.json` file containing all information (bug, project, and otherwise).
   * A `metadata.config` file containing bug- and project-specific information, for use in scripts.

   Perhaps, the following will no longer be necessary when using the `metadata.config` file to setup all these scripts, without having to copy-paste them around.
   * An executable `get-buggy.sh` file to clone the project and setup the buggy commit.
   * An executable `get-fixed.sh` file to clone the project and setup the fixed commit.
   * An executable `get-tested.sh` file to clone the project and setup the tested commit.









