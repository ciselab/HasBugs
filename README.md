# Rhodos - A ML Fault Benchmark for Java

> "Hic Rhodus, Hic Salva"
> (Here is Rhodes, here you can jump)
> 
> --- Äsop

Welcome to the Rhodos Benchmark. 
We try to provide a fresh dataset in the fashion of [Defects4J](https://github.com/rjust/defects4j) to evaluate tasks such as fault localization, program repair and test generation.
Within the Dataset, we specialize on Machine-Learning Projects, as they have a set of interesting properties: 

- High amount of computation and maths, often as *pure functions* 
- Less dependencies, less coupling
- Building bricks for modern applications
- ML is of high interest at the moment

Instead of just providing the commits, we learned from some of the datasets out there, which we address in the following: 

- A failing CI does not mean a bug - atleast not certainly from the code. Hence, our bug-points are aknowledged by the project-maintainers through PRs and Issues. This also means that the *buggy version* of the datapoints usually compiles. 
- Similarly, the Fix is what the maintainers consider fixed (even if that is removal of a feature).
- For the test-cases we provide, we try to get feedback from the maintainers whether they can be considered an accurate test-case. We do so by PR to their project.  
- As research by [Martin Monperrus](https://link.springer.com/article/10.1007/s10664-016-9470-4) showed, not all found patches in program repair actually help despite passing the test-suite. 
  To help with the inspection of potential tasks, we look into the material provided (code, issues, project readme/architecture) to give a simple estimate of "what is buggy".
  We hope that this helps to easier distinguish actually good result from e.g. overfitting.
- We can express multiple bug and fix locations in the datapoint

The aim of these changes is to provide a (small) dataset with bugs from real-world problems of which all steps are aknowledged by their maintainers (the bug, the test & the fix).
We do not try to provide a dataset in the size that you can run deep learning on it - but we want to have a quality gold standard to benchmark modern tools against.
Furthermore, we want to provide a dataset for people to build modern tools, that use for example java modules or records and cannot utilize Java 8 code. 

## Datapoint 

For every project, we provide 

- The buggy version
- The fixed version
- Iff the buggy version does not have a failing test, a git-patch to create a buggy-but-tested version
- A datapoint for analysis (see below)

A single datapoint can contain the following attributes (required attributes are marked with *, but these stars are not in the actual json!): 

```JSON
{
    "*id":42,
    "*repositoryurl": "https://github.com/ciselab/rhodos",
    "*repository":"Ciselab/Rhodos",
    "*licence":"MIT",
    "*faultcommit":"xxx",
    "*fixcommit":"yyy",

    "javaversion":9,
    "buildframework":"Maven",
    "testframeworks" : ["JUnit"],

    "testpatch":true,
    "description": "Input Sanitazion missing - divides by zero",
    "categories" : ["Sanitazion", "DivideByZero"], 

    "relatedissues" : ["https:www.github.com/ciselab/rhodos/issues/1"],
    "relatedprs" : ["https:www.github.com/ciselab/rhodos/issues/2"],

    "*faultlocations" : [
        {
            "*startline": 5,
            "*endline": 15,
            "*file" : "./project/.../program.java",
            "class" : "fully.qualified.package.program",
            "method": "Main()"
        },{
            "*startline": 25,
            "*endline": 35,
            "*file" : "./project/.../program.java",
            "class" : "fully.qualified.package.program",
            "method": "helper"
        }
    ],
    "*fixlocations" : [
        {
            "*startline": 5,
            "*endline": 20,
            "*file" : "./project/.../program.java",
            "class" : "fully.qualified.package.program",
            "method": "Main()"
        }
    ]
}
```

For a few more sentences on the datapoint fields and the commits see [datapoint-notes](./template/datapoint-notes.md).

You can either fill the things provided in [template](./template) or you fill the datapoint and then have a look at [the templater](./tools/templater).
It does most of the template filling, it just doesn't do the patches.

## Layout 

- The folder `./references` contains the items to pull and setup a single datapoint. They are organized by `./references/repository/id`.
- `./template` contains a set of a copy-pastable entry to make new references. Also, it holds [instructions how to work with git patches](./template/git-helpers.md).
- The folder `./tools` contains helpers to organize the references, e.g. to pull all datapoints or remove them.
- The folder `./data` contains the actual projects & dataset after you ran the tools to download everything. They are organized in folders by `./data/id`. 

## Inclusion Criteria 

- Java >= 8 
- Junit Tests 
- Projects run with a single `mvn test` or `gradle build` (low magic fantasy-setting)
- buggy version newer than 2018
- bug and fix aknowledged as such by the maintainer(s) through Github Issues / PRs 