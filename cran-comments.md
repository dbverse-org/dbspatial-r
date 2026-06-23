## Resubmission

This is a resubmission. In response to the previous CRAN feedback, I:

* fixed `as_dbSpatial(..., temporary = FALSE)` so it creates persistent
  database tables as documented
* changed DuckDB spatial extension loading so extension files are installed
  into the R session temporary directory rather than the user/package library
* skipped DuckDB spatial extension runtime checks and vignette execution on
  CRAN

## Test environments

* local R 4.6.0 on x86_64-pc-linux-gnu (Ubuntu 24.04, WSL2)

## R CMD check results

`NOT_CRAN=false R CMD check --as-cran --no-manual`

* 0 errors
* 0 warnings
* 0 notes

Full `R CMD check --as-cran` was also run locally. It reached the PDF manual
step with all package checks passing, then failed because `pdflatex` is not
available in the local WSL2 environment.
