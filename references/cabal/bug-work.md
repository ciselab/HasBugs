### Bug 1:
'cabal run' termination does not terminate all child processes automatically as well. The solution is to use 'withCreateProcess' rather than 'createProcess' and throw an asynchronous exception from the main thread when a termination is wanted.

Fix commit: 55e036a2c40586bc0f69aaa7d85aab931a0a5c80
Fault commit: 0184445b83af20dd9bb0e2ec09a8ba4b8d14a755

PRS:
https://github.com/haskell/cabal/pull/7921, https://github.com/haskell/cabal/pull/7757

Issues:
https://github.com/haskell/cabal/issues/7914

Fix:


Test:

GHC: 8.10.7

Categories:
system-test


### Bug 2:


Fix commit:
Fault commit:

PRS:


Issues:


Fix:

Test:

GHC: 8.10.7

Categories: 


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



