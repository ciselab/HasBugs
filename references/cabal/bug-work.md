https://github.com/haskell/cabal/issues?q=is%3Aissue+is%3Aclosed+linked%3Apr+label%3A%22type%3A+bug%22

### Bug 1: (TESTS FAIL SUCCESSFULLY)
'cabal run' termination does not terminate all child processes automatically as well. The solution is to use 'withCreateProcess' rather than 'createProcess' and throw an asynchronous exception from the main thread when a termination is wanted.

Fix commit: 55e036a2c40586bc0f69aaa7d85aab931a0a5c80
Fault commit: 0184445b83af20dd9bb0e2ec09a8ba4b8d14a755

PRS:
https://github.com/haskell/cabal/pull/7921, https://github.com/haskell/cabal/pull/7757

Issues:
https://github.com/haskell/cabal/issues/7914

Fix:
Cabal/src/Distribution/Simple/Program/Run.hs
Distribution.Simple.Program.Run
From: 127-127, 131-132
To: 127-127

cabal-install/main/Main.hs
Main
From: 
To: 175-175

cabal-install/src/Distribution/Client/ProjectConfig.hs
Distribution.Client.ProjectConfig
From: 1196-1197
To: 1196-1196

cabal-install/src/Distribution/Client/Signal.hs
Distribution.Client.Signal
From: 
To: 1-49

Test:
cabal-testsuite/PackageTests/NewBuild/CmdRun/Terminate/Main.hs
cabal-testsuite/PackageTests/NewBuild/CmdRun/Terminate/RunKill.cabal
cabal-testsuite/PackageTests/NewBuild/CmdRun/Terminate/cabal.project
cabal-testsuite/PackageTests/NewBuild/CmdRun/Terminate/cabal.test.hs
cabal-testsuite/src/Test/Cabal/Run.hs

GHC: 8.10.7

Categories:
system-test


### Bug 2:
'cabal init -i' does not automatically fill in author name and e-mail anymore. The solution is to add a guess to the prompt.

Fix commit: 1b8bf8ccb58c131efcbb3925bcbb5bd4c14adc03
Fault commit: 2e9af5bb241f187bedf149d2ef272570384e5991

PRS:
https://github.com/haskell/cabal/pull/8267

Issues:
https://github.com/haskell/cabal/issues/8255

Fix:
cabal-install/src/Distribution/Client/Init/Interactive/Command.hs
Distribution.Client.Init.Interactive.Command
From: 358-359, 362-363
To: 359-361, 364-366

Test:
cabal-install/tests/UnitTests/Distribution/Client/Init/Golden.hs
cabal-install/tests/UnitTests/Distribution/Client/Init/Interactive.hs

GHC: 8.10.7

Categories: 
golden-test, unit-test

### Bug 3: (TESTS FAILED SUCCESSFULLY)
'cabal HEAD' is confused by trailing whitespaces in 'default-language' tags. The solution is to fix parsing from 'some' to 'munch1'.

Fix commit: 52cc82d430e6b9efa4024138119cc26b787d47ad
Fault commit: a49c1ddae0d768b6978cac76a50a01447e7066b6

PRS:
https://github.com/haskell/cabal/pull/8508

Issues:
https://github.com/haskell/cabal/issues/8507

Fix:
Cabal-syntax/src/Language/Haskell/Extension.hs
Language.Haskell.Extension
parsec
From: 80-80
To: 80-80

Test:
cabal-testsuite/PackageTests/Regression/T8507/Foo.hs
cabal-testsuite/PackageTests/Regression/T8507/cabal.out
cabal-testsuite/PackageTests/Regression/T8507/cabal.project
cabal-testsuite/PackageTests/Regression/T8507/cabal.test.hs
cabal-testsuite/PackageTests/Regression/T8507/pkg.cabal
fix-whitespace.yaml

GHC: 8.10.7

Categories: 
system-test


### Bug 4:


Fix commit:
Fault commit:

PRS:

Issues:

Fix:

Test:

GHC: 8.10.7

Categories: 


### Bug 5:


Fix commit:
Fault commit:

PRS:

Issues:

Fix:

Test:

GHC: 8.10.7

Categories: 



