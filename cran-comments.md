## Submission

This is a patch release fixing the ERROR shown on the CRAN check page for
dbSpatial 0.1.2 on r-devel-linux-x86_64-fedora-clang. In this version I:

* fixed the vignette evaluation guard so DuckDB spatial chunks are skipped on
  CRAN; the previous guard evaluated them when `NOT_CRAN` was unset, which
  failed where DuckDB extension loading is disabled
* added `\usage` sections to the `st_*` method help topics, resolving the
  "Rd files without \usage" NOTE on r-devel-linux-x86_64-debian-clang and
  r-devel-linux-x86_64-debian-gcc

## Test environments

* local R 4.6.0 on x86_64-pc-linux-gnu (Ubuntu 24.04, WSL2)

## R CMD check results

`R CMD check --as-cran --no-manual` with `NOT_CRAN` unset

* 0 errors
* 0 warnings
* 0 notes

## Reverse dependencies

There are no reverse dependencies on CRAN.
