### Bug 2:
Predicates were not being parsed 

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

