### Bug 1:
When records are punned, there is a reference from pun to field declaration and from pun-name use to pun-declaration, but no transitive one. Meaning refactoring did not propagate to the latter. Solution is a second pass to find indirect pun references and rename those as well.

Fix commit: 0f6cd41d51e1dd81ddeb117ab949ceb1f38e68cf
Fault commit: ffefe761c8210c6b4a0c5092935f34767a3cd827

PRS:
https://github.com/haskell/haskell-language-server/pull/3013

Issues:
https://github.com/haskell/haskell-language-server/issues/2970

Fix:
plugins/hls-rename-plugin/src/Ide/Plugin/Rename.hs
From: 69-77, 96-96
To: 68-88, 107-107, 249-253

Test:
plugins/hls-rename-plugin/test/Main.hs
plugins/hls-rename-plugin/test/testdata/FieldPuns.expected.hs
plugins/hls-rename-plugin/test/testdata/FieldPuns.hs
plugins/hls-rename-plugin/test/testdata/IndirectPuns.expected.hs
plugins/hls-rename-plugin/test/testdata/IndirectPuns.hs
plugins/hls-rename-plugin/test/testdata/hie.yaml

Command: `stack test plugins/hls-rename-plugin`

Integration test because it runs the entire language server analysis?
But unit test in what it attempts to assert?

GHC: 9.2.3

Categories:
integration-test


### Bug 2:
First character of a suggested module name is dropped when `hs-source-dirs` is assigned simply as '.' ('./' was expected). Fix is to canonicalise the path to always include the '/' and then trim it. (The PR also adds cleaner logging for debugging)

Fix commit: 49373fd01465d56146fa5f1ceded3907ad520ca0
Fault commit: 548ca17cc73546407ac6e2cd26068a12f2d56af7

PRS:
https://github.com/haskell/haskell-language-server/pull/3092

Issues:
https://github.com/haskell/haskell-language-server/issues/3047

Fix:
plugins/hls-module-name-plugin/src/Ide/Plugin/ModuleName.hs
From: 127-127, 136-136
To: 143-143, 156-156

Test:
plugins/hls-module-name-plugin/hls-module-name-plugin.cabal
plugins/hls-module-name-plugin/test/Main.hs
plugins/hls-module-name-plugin/test/testdata/cabal.project
plugins/hls-module-name-plugin/test/testdata/canonicalize/Lib/A.expected.hs
plugins/hls-module-name-plugin/test/testdata/canonicalize/Lib/A.hs
plugins/hls-module-name-plugin/test/testdata/canonicalize/canonicalize.cabal
plugins/hls-module-name-plugin/test/testdata/hie.yaml

Command: `stack test plugins/hls-module-name-plugin`

GHC: 8.10.7

Categories:
off-by-one, path-trimming, integration-test


### Bug 3:


Fix commit:
Fault commit:

PRS:

Issues:

Fix:

Test:

GHC: 8.10.7

Categories:


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


