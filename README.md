# HasBugs - Handpicked Haskell Bugs

We try to provide a fresh dataset in the fashion of [Defects4J](https://github.com/rjust/defects4j) to evaluate tasks such as fault localization, program repair and test generation.

Instead of just providing the commits, we learned from some of the datasets out there, which we address in the following: 

- A failing CI does not mean a bug - atleast not certainly from the code. Hence, our bug-points are aknowledged by the projects through PRs and Issues. This also means that the *buggy version* of the datapoints usually compiles. 
- Similarly, the Fix is what the maintainers consider fixed (even if that is removal of a feature).
- As research by [Martin Monperrus](https://link.springer.com/article/10.1007/s10664-016-9470-4) showed, not all found patches in program repair actually help despite passing the test-suite. 
  To help with inspection of potential tasks, we look into the material provided (code, issues, project readme/architecture) to give a estimate of "what is buggy".
  We hope this helps to easier distinguish actually good result from e.g. overfitting.
- We express multiple bug and fix locations in the datapoint

The aim of these changes is to provide a (small) dataset with bugs from real-world problems of which all steps are aknowledged by their maintainers (the bug, the test & the fix).
We do not try to provide a dataset in the size that you can run deep learning on it - but we want to have a quality gold standard to benchmark modern tools against.

## Datapoint 

For every project, we provide 

- The buggy version
- The fixed version
- The tested (and failing) version
- A git-patch of the test
- A datapoint for analysis (see below)

A single datapoint can contain the following attributes (required attributes are marked with *, but these stars are not in the actual json!): 

```JSON
{
    "*id":42,
    "*repositoryurl": "https://github.com/ciselab/HasBugs",
    "*repository":"Ciselab/HasBugs",
    "*licence":"MIT",
    "*faultcommit":"xxx",
    "*fixcommit":"yyy",

    "ghc-version":"9.2.4",
    "buildframework":"Cabal",
    "testframeworks" : ["QuickCheck","Tasty"],

    "testpatch":true,
    "description": "Input Sanitazion missing - divides by zero",
    "categories" : ["Sanitazion", "DivideByZero"], 

    "relatedissues" : ["https:www.github.com/ciselab/HasBugs/issues/1"],
    "relatedprs" : ["https:www.github.com/ciselab/HasBugs/issues/2"],

    "*faultlocations" : [
        {
            "*startline": 5,
            "*endline": 15,
            "*file" : "./project/.../program.hs",
            "module" : "Math.Divison",
            "method": "divide"
        },{
            "*startline": 25,
            "*endline": 35,
            "*file" : "./project/.../program.hs",
            "module" : "Math.Divison",
            "method": "divide"
        }
    ],
    "*fixlocations" : [
        {
            "*startline": 5,
            "*endline": 20,
            "*file" : "./project/.../program.hs",
            "module" : "Math.Divison",
            "method": "divide"
        }
    ]
}
```

For a few more sentences on the datapoint fields and the commits see [datapoint-notes](./template/datapoint-notes.md).

To add a new datapoint, run `setup.sh` and the accompanying tools in `./tools`. The shell scripts will ask you for some information on the command line.

## Layout 

- The folder `./references` contains the items to pull and setup a single datapoint. They are organized by `./references/repository/id`.
- The folder `./tools` contains helpers to organize the references, e.g. to pull all datapoints or remove them.
- The folder `./data` contains the actual projects & dataset after you ran the tools to download everything. They are organized in folders by `./data/id`. 

## Inclusion Criteria 

- Compatible with GHC >=8.10
- Projects run with a single `make test`, `cabal test` or `stack test` 
- buggy version newer than 2018
- bug and fix aknowledged as such by the maintainer(s) through Github Issues / PRs 
