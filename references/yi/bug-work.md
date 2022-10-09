### Bug 1:
@@ should replay the last used macro with Vim bindings, but didn't.

Fix commit: 909ef8329157fc89850a76e22a3542423ca371ac
Fault commit: 20fbaea9353e02c353b882c8e83f89c3d88d720f

PRS:
https://github.com/yi-editor/yi/pull/1028

Issues:
https://github.com/yi-editor/yi/issues/1026

Fix:
yi-keymap-vim/src/Yi/Keymap/Vim/NormalMap.hs
Yi.Keymap.Vim.NormalMap
From: 493-497
To: 493-496, 512-513

Test:
yi-keymap-vim/tests/vimtests/macros/repeat_last_macro.test

GHC: 8.2.2

Categories:
integration-test, golden-test


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



