### Bug 1:
Too old, can't use this one... :(
I can't easily install the library for it


### Bug 2:


Fix commit:
Fault commit:

PRS:

Issues:


### Bug 3:
Incorrect parsing for alias regexes, solved by adding the right 'between' and adding a line for allowing any character to be doubly escaped.

Fix commit: a65e64115a1e19033c3d51bb1a89081e6a03d3aa
Fault commit: 852ba7b10000077c6d77eda50bf76ea1019f0368

PRS:
https://github.com/simonmichael/hledger/pull/1832

Issues:
https://github.com/simonmichael/hledger/issues/982


### Bug 4:
Auto-generated postings without explicit amount needed to be displayed with one. The fix is to generate an amount for auto-postings without one.

Fix commit: 4006ab6d2d5623fbba9a64ae70722ac1b94da3ad
Fault commit: 9d5397deb6d5d6e449221d35286f6e80f750cf55

PRS:
https://github.com/simonmichael/hledger/pull/1714

Issues:
https://github.com/simonmichael/hledger/issues/1276


### Bug 5:


Fix commit:
Fault commit:

PRS:

Issues:


### Bug 6:


Fix commit:
Fault commit:

PRS:

Issues:



### Bug -1:
Predicates were not being parsed

But parsing predicates was never tested anywhere (some of these issues should have been compile-time?)

Fix commit: 04c35e1519840831c36563dc6e1db32f10beb534
Error commit: db45b13249af89e4bf60e4345276250e52e77690

Issues: 
https://github.com/simonmichael/hledger/issues/1108
https://github.com/simonmichael/hledger/issues/1464

Prs:
https://github.com/simonmichael/hledger/pull/1686

No test yet!!!


One part of the bug is that report fields are renamed, but the rename is not yet propagated to scripts for running CLI.
(_rsOpts -> _rsReportOpts)



Put in category? unit/integration
