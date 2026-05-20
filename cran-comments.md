## Resubmission

This is a resubmission. In response to the previous CRAN feedback, I:

* added method references to the `Description` field in `DESCRIPTION`
* added the missing `\value{}` sections for the flagged exported methods and documented the returned object structure
* removed user-facing documentation that accessed internal helpers via `:::`
* replaced inappropriate `\dontrun{}` examples with `\donttest{}` examples

## Test environments

* local R 4.5.2 on x86_64-pc-linux-gnu (AlmaLinux 8.10)

## R CMD check results

`R CMD check --as-cran`

* 0 errors
* 2 warnings: local `qpdf` not available; local LaTeX package `inconsolata.sty` missing for the PDF manual
* 4 notes: new submission; current time could not be verified on this host; HTML Tidy not available locally; `dbSpatial-manual.tex` left in check dir because the local PDF manual step failed
