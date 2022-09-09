# Git helpers 

This file holds some infos on how to handle the git parts of the project. 

## What is a Git Patch? 

A patch is little more than a "portable" commit.

If I give you a patch for your project, you can apply it and your project will be added a change of code similar to pulling a new commit.

A patch is also created exactly the same way - it is build from commits (see below).

## Inspect Patches 

Patches ought to be readable by design. 
You see can e.g. cat them `cat xxx.patch` or open them in an editor. 

## Producing Git Patches for Tests

Step 1: Get the Project at the Buggy Commit (keeping history), keep hash ready for copy

Step 2: Checkout a new Branch, call it something like testRegression

Step 3: Work on your branch and add the test

Step 4: Make a SINGLE commit to add your test

Step 5: Run `git diff --oneline --graph bugCommitHash testRegression` (it should show your commit, verify before next step for noise)

Step 6: While in the testRegression-branch run `git format-patch bugCommitHash` should create a .patch file named by your commit message.

## Producing Diff-Patches 

Step 1: Go to the project with history, keep the bugCommit and fixCommit in mind

Step 2: Run `git format-patch bugCommit..fixCommit --stdout > totalDiff.patch`

You optionally can use `bugCommit^`, that means to include the changes introduced by the bug commit to the totalDiffPatch

## Applying Git Patches 

In the branch where you want to have the patch just run `git am xxx.patch`. You might get merge conflicts, that you have to resolve similar to normal git. 
This should not be the case for this project though.

You can first check with `git apply --check xxx.patch` to spot potential errors.