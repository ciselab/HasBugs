### Bug 1: (TEST FAILED SUCCESSFULLY)
When records are punned, there is a reference from pun to field declaration and from pun-name use to pun-declaration, but no transitive one. Meaning refactoring did not propagate to the latter. Solution is a second pass to find indirect pun references and rename those as well.

```haskell
data Rec = Rec { field :: Int }

usage :: Rec -> Int
usage Rec{field} = field

```

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


### Bug 2: (TEST FAILED SUCCESSFULLY)
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


### Bug 3: (TEST FAILED SUCCESSFULLY)
Completions did not contain locally defined type families. The fix is to add type family definitions in class declarations.

Fix commit: c3c73cf30bf8b59182e6df674e3f804b55b062ea
Fault commit: 771d8f44e694c70d0ee487f2bd6d095fd5e1b99f

PRS:
https://github.com/haskell/haskell-language-server/pull/2987

Issues:

Fix:
ghcide/src/Development/IDE/Plugin/Completions/Logic.hs
From: 465-465, 469-469
To: 465-465, 469-471

Test:
test/functional/Completion.hs

GHC: 8.10.7

Categories:
integration-test


### Bug 4: (TEST FAILED SUCCESSFULLY)
Location of generated imports is somewhat incorrect, it may be inserted before the 'where' of a module declaration. 

Fix commit: 0b8c793dfdf0d6adb1d4704343fa512c7646a15a
Fault commit: cdc8f78a9852ed35cbfccc191a0b87f59dc9e271

PRS:
https://github.com/haskell/haskell-language-server/pull/2981

Issues:
https://github.com/haskell/haskell-language-server/issues/2414

Fix:
ghcide/src/Development/IDE/Plugin/CodeAction.hs
From: 1391-1392, 1397-1403
To: 1412-1419, 1424-1428, 1430-1494

Test:
ghcide/test/data/import-placement/WhereDeclLowerInFileWithCommentsBeforeIt.expected.hs
ghcide/test/data/import-placement/WhereDeclLowerInFileWithCommentsBeforeIt.hs
ghcide/test/exe/Main.hs

GHC: 8.10.7

Categories:
integration-test


### Bug 5:


Fix commit:
Fault commit:

PRS:

Issues:

Fix:

Test:

GHC: 8.10.7

Categories:



### Bug -1:
Don't think this would make for a good test, since we would need to test that an added warning is thrown.

Fix commit: c045857ecbb00c0c0757e3e3ef5fefcd3a4dac99
Fault commit: 100b53a4744c21501c925d8a9261c38b840f69be

PRS:
https://github.com/haskell/haskell-language-server/pull/2995

Issues:

Fix:

Test:
Needs one!

GHC: 8.10.7

Categories:


### Bug -2:
Bug reads more like an error-by-design at first rather than a mistake.

Fix commit:
Fault commit:

PRS:
https://github.com/haskell/haskell-language-server/pull/2788

Issues:
https://github.com/haskell/haskell-language-server/issues/2786

Fix:
ghcide/src/Development/IDE/Plugin/Completions/Logic.hs


Test:
ghcide/test/exe/Main.hs
test/functional/Completion.hs

GHC: 8.10.7

Categories:


