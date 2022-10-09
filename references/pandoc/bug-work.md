### Bug 1:
xref elements can link to figures, but the text inserted for the title of the link would be 'figure_title' rather than the title of the figure. The fix is to add the 'title' attribute to a switch selecting the attribute to use as a title.

Fix commit: b888a8c77e35cc028725aff0f581475ec0481af9
Fault commit: b0195b7ef4d55c1d7339cd77aa0e3a039a095807

PRS:
https://github.com/jgm/pandoc/pull/8065

Issues:
https://github.com/jgm/pandoc/issues/8064

Fix:
src/Text/Pandoc/Readers/DocBook.hs
Text.Pandoc.Readers.DocBook
From: -
To: 1345-1345

Test:
test/docbook-xref.docbook
test/docbook-xref.native

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



