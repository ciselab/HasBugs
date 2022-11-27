https://github.com/haskell/cabal/issues?q=is%3Aissue+is%3Aclosed+linked%3Apr+label%3A%22type%3A+bug%22

### Bug 1: (TEST FAILS SUCCESSFULLY))
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


### Bug 2:  (TESTS FAILED SUCCESSFULLY)
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
'cabal HEAD' is confused by trailing whitespaces in 'default-language' tags. The solution is to fix parsing from 'some anyChar' to 'munch1 isAlphaNum'.

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
'--dry-run' did not actually dry-run for commands 'v2-configure', 'v2-freeze', 'v2-run', and 'v2-exec'. Instead, the dry-run flag was ignored and the commands did perform a few actions. The fix is to add if-expressions where needed in the commands' code to perform the dry-run as expected.

Fix commit: 84884bbc21a63b61d698138f549baae152efd878
Fault commit: aabe56252fcceb58f2f3f80451bba7ca13109266

PRS:
https://github.com/haskell/cabal/pull/7407

Issues:
https://github.com/haskell/cabal/issues/7379

Fix:
cabal-install/src/Distribution/Client/CmdConfigure.hs
Distribution.Client.CmdConfigure
From: 92-94, 104-104, 109-121
To: 92-99, 113-131, 137-142

cabal-install/src/Distribution/Client/CmdExec.hs
Distribution.Client.CmdExec
From: 188-188
To: 190-195

cabal-install/src/Distribution/Client/CmdFreeze.hs
Distribution.Client.CmdFreeze
From: 119-121
To: 109-110, 120-128

cabal-install/src/Distribution/Client/CmdRun.hs
Distribution.Client.CmdRun
From: 286-294
To: 286-300


Test:
cabal-testsuite/PackageTests/NewConfigure/ConfigFile/ConfigFile.cabal
cabal-testsuite/PackageTests/NewConfigure/ConfigFile/Setup.hs
cabal-testsuite/PackageTests/NewConfigure/ConfigFile/cabal.out
cabal-testsuite/PackageTests/NewConfigure/ConfigFile/cabal.project
cabal-testsuite/PackageTests/NewConfigure/ConfigFile/cabal.test.hs
cabal-testsuite/PackageTests/NewFreeze/FreezeFile/new_freeze.out
cabal-testsuite/PackageTests/NewFreeze/FreezeFile/new_freeze.test.hs

GHC: 8.10.7

Categories: 
system-test, golden-test

### Bug 5:
When initialising a project with the '--no-comments' flag, cabal fields that would normally be commented out still had comments in front of them. Expected behaviour was that comments were not present in front of any fields, commented out or not. Solution is to always remove comments when the '--no-comments' flag is set.

Fix commit: 41ed090a399791ff3a65f4059aa987e37fa9d262
Fault commit: e74a53b3d8b1a52cb86a8232e2e745d1bd64a8d7

PRS:
https://github.com/haskell/cabal/pull/7770

Issues:
https://github.com/haskell/cabal/issues/7769

Fix:
cabal-install/src/Distribution/Client/Init/Format.hs
Distribution.Client.Init.Format

fieldD
From: 67-78, 95-95
To: 67-69, 78-82, 91-91

withComments
From: 107-107
To: 103-105

Test:
cabal-install/tests/UnitTests/Distribution/Client/Init/Golden.hs
cabal-install/tests/fixtures/init/golden/cabal/cabal-lib-and-exe-no-comments.golden
cabal-install/tests/fixtures/init/golden/cabal/cabal-lib-no-comments.golden
cabal-install/tests/fixtures/init/golden/cabal/cabal-test-suite-no-comments.golden
cabal-install/tests/fixtures/init/golden/exe/exe-no-comments.golden
cabal-install/tests/fixtures/init/golden/lib/lib-no-comments.golden
cabal-install/tests/fixtures/init/golden/lib/lib-simple-no-comments.golden
cabal-install/tests/fixtures/init/golden/test/standalone-test-no-comments.golden
cabal-install/tests/fixtures/init/golden/test/test-no-comments.golden

GHC: 8.10.7

Categories: 
golden-test, existing-tests, system-test

### Bug 6:
Multiple concurrent builds would sometimes give an error similar to 'ghc-pkg: cannot create: /home/edsko/path/to/main-package/dist-newstyle/packagedb/ghc-7.10.3 already exists' because packagedbs would be made at the same time. The solution is to initialise packagedbs at the start of the build process rather than when needed.

Fix commit: 5adaf5855c856f1f2400c1a5821bc97503b413bc
Fault commit: e69172166e1af60830247442939f413d472f0689

PRS:
https://github.com/haskell/cabal/pull/3509

Issues:
https://github.com/haskell/cabal/issues/3460

Fix:
cabal-install/Distribution/Client/ProjectBuilding.hs
From: 578-578
To: 578-581 (rebuildTargets), 599-599 (rebuildTargets), 626-633 (rebuildTargets)

cabal-install/Distribution/Client/ProjectPlanning.hs
From: 625-626, 645-653
To: 625-625 (getPackageDBContents), 648-655 (createPackageDBIfMissing)


Test:
cabal-install/cabal-install.cabal
cabal-install/tests/IntegrationTests/new-build/T3460.sh
cabal-install/tests/IntegrationTests/new-build/T3460/C.hs
cabal-install/tests/IntegrationTests/new-build/T3460/Setup.hs
cabal-install/tests/IntegrationTests/new-build/T3460/T3460.cabal
cabal-install/tests/IntegrationTests/new-build/T3460/cabal.project
cabal-install/tests/IntegrationTests/new-build/T3460/sub-package-A/A.hs
cabal-install/tests/IntegrationTests/new-build/T3460/sub-package-A/Setup.hs
cabal-install/tests/IntegrationTests/new-build/T3460/sub-package-A/sub-package-A.cabal
cabal-install/tests/IntegrationTests/new-build/T3460/sub-package-B/B.hs
cabal-install/tests/IntegrationTests/new-build/T3460/sub-package-B/Setup.hs
cabal-install/tests/IntegrationTests/new-build/T3460/sub-package-B/sub-package-B.cabal

GHC: 8.10.7

Categories: 
system-test

### Bug 7:


Fix commit: 
Fault commit: 

PRS:


Issues:


Fix:


Test:


GHC: 8.10.7

Categories: 




