# Info on Datapoints

## Datafields

**Paths**: All paths of a datapoint are relative to project root, not to benchmark root. 

**Classes**: Classes are a bit hard, as maybe there are inner classes, multiple classes withing a file etc. 
Hence, classes where considered optional for locations. Same goes for methods (just that methods are even more ambigious).
**For most cases, you should work with the Lines+File!**.

**Java Version**: If any version is specified in the gradle or pom file. Otherwise, the authors added the JDK version on which they ran the build & test.

**Related Issues & PRs**: Are *only* filled if they were connected using Github-Markup. We do not do an exhaustive search over all PRs and Issues of a Project and do not claim exhaustiveness either. 
For the dataset, we looked into the issues and PRs that are bug fixes, and we add the PRs & Issues found from this search, and the ones connected/mentioned to it.

**TestPatch**: Whether we (the authors) provide a test-patch that supplies the buggy version with a test. 
If true, we provide one, if false, the project is already tested for the bug with a failing test-case.

## After Reference Layout 

For every project, the folder data will contain a folder by the ID:

```
rhodos-benchmark
    /data
        /1
            /buggy
                pom.xml
                /src
                ...
            /tested
            /fixed
            datapoint.json
        /2
            ...
        ...
        dataset.json
```

## About Multi-Commit Fixes 

Sometimes, fixes take more than one commit. 
Consider the following history: 

```
                --> Fix Part A -- > Fix Part B --> Fixed Version
             /                                                  \
Buggy Main -->                 other Commits                   ---> Fixed Main
```

In that case, the `FixCommit` resembles the "Fixed Main" from aboves picture, 
and `BugCommit` is "Buggy Main" from above. 
The Fix and Fault Locations are the *related* changes touched by "Fix Part A" & "Fix Part B", 
i.e. the touched but not important files from "Other Commits" are not in the datapoint.
Hence, the reported Fix and Fault Locations in the .json do not cover the full diff of "Buggy Main" to "Fixed Main". 
For this, we provide a [stashed git patch](https://stackoverflow.com/questions/5308816/how-to-use-git-merge-squash) that goes from "Buggy Main" to "Fixed Main" in a single commit. 
See [git-helpers](./git-helpers.md) for more how the patches are created and applied.

Elements deemed *important* are choosen carefully by the authors. 
You can consider this a threat to validity, but if you want to pick a fight just call me. :rage: 

## TODOS:

- [] How to deal with Bugs that persist over many versions ? Do we pick the git-parent of the first fix-commit or the very first version the bug was found ?