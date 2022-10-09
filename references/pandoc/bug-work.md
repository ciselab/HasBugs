## Search using
https://github.com/jgm/pandoc/issues?q=is%3Aissue+label%3Abug+is%3Aclosed+linked%3Apr

## Bugs

### Bug 1: (TESTS FAIL SUCCESSFULLY)
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


### Bug 2: (TESTS FAIL TO RUN: tasty-lua fails to compile...)
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
When multiple paragraphs were present under a single list item, DOCXs would annotate each paragraph with the list item number, but should instead only annotate the first. Fix is to add a marker that is set when the first annotation is done and checked on every subsequent annotation.

Fix commit: 5001fd3f4d0daee5802a78f6d99d538ff9db4336
Fault commit: a25e79b5bef9a55c076351d1321675e26513f8ac

PRS:
https://github.com/jgm/pandoc/pull/7822

Issues:
https://github.com/jgm/pandoc/issues/7689

Fix:
src/Text/Pandoc/Writers/Docx.hs
Text.Pandoc.Writers.Docx
From: 978-983, 1020-1020
To: 977-983, 1018-1022, 1025-1025

src/Text/Pandoc/Writers/Docx/Types.hs
Text.Pandoc.Writers.Docx.Types
From: -
To: 114-115


Test:
test/Tests/Writers/Docx.hs
test/docx/golden/lists_div_bullets.docx
test/docx/lists_div_bullets.native

GHC: 8.10.7

Categories: 
integration-test, golden-test


### Bug 4: (TESTS FAIL SUCCESSFULLY)
Formatting in code blocks is not allowed by pandoc, causing bold code to be possible but a code block with parts bold in it impossible for LaTeX. The fix is to make sure formatting of a code block happens outside of the codeblock.

Fix commit: f317ec41a1948e35330364c3120d937cc9934888
Fault commit: a21d6e9fa6d9e0287b6db05fc663810337ef3f9a

PRS:
https://github.com/jgm/pandoc/pull/8129

Issues:
https://github.com/jgm/pandoc/issues/7525

Fix:
src/Text/Pandoc/Readers/LaTeX.hs
Text.Pandoc.Readers.LaTeX
From: 350-350, 371-371, 410-411
To: 350-350, 371-371, 410-411

src/Text/Pandoc/Shared.hs
Text.Pandoc.Shared
From: -
To: 783-802


Test:
test/command/7525.md

GHC: 8.10.7

Categories:
integration-test


### Bug 5:
When a code-block starts with a period, ROFF MS interpreted this as a command rather than a part of the code-block. The solution is to escape the periods.

Fix commit: c3b170be1c3c11465e5b0a64b6f59c875323a592
Fault commit: 651a3d96c499a27556f6a12591bc04bd4cba7630

PRS:
https://github.com/jgm/pandoc/pull/6513

Issues:
https://github.com/jgm/pandoc/issues/6505

Fix:
src/Text/Pandoc/Writers/Ms.hs
Text.Pandoc.Writers.Ms
From: 207-207
To: 207-209

Test:
test/Tests/Writers/Ms.hs
test/test-pandoc.hs

GHC: 8.10.7

Categories: 
integration-test, close-to-unit-test



## Possible bugs

CSS bug rather than HS: https://github.com/jgm/pandoc/pull/7424
Needs a test (-1): https://github.com/jgm/pandoc/issues/7523



### Bug -1:
Could perhaps be done by making a test for it. The issue comes with an example programme, but they never integrated it into the test suite.

Fix commit:
Fault commit:

PRS:

Issues:
https://github.com/jgm/pandoc/issues/7523

Fix:

Test:

GHC: 8.10.7

Categories: 


