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
When a file was rendered into DOCX with two tables in them, the space between them would be deleted when there was some comment block in-between. However, the comment should be ignored and a paragraph should be inserted anyway for spacing.

Fix commit: e146b1ff3b1c4204a678269a967d94f1df4b38c0
Fault commit: 6b7a68869593bbf8097bbcd39021fcaa3523270e

PRS:
https://github.com/jgm/pandoc/pull/7844

Issues:
https://github.com/jgm/pandoc/issues/7724

Fix:
src/Text/Pandoc/Writers/Docx.hs
Text.Pandoc.Writers.Docx
blocksToOpenXML, isForeignRawBlock
From: 772-772
To: 772-776

Test:
test/Tests/Writers/Docx.hs
test/docx/golden/tables_separated_with_rawblock.docx
test/docx/tables_separated_with_rawblock.native

GHC: 8.10.7

Categories:
integration-test, golden-test


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



