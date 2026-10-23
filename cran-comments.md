## Submission

This is a patch release shortly after 0.1.3 because it fixes silently
incorrect results. In this version I:

* fixed `as_dbSpatial()` rounding coordinates to 7 significant digits
  (for example 6840.2705 became 6840.27). This has affected every release
  since 0.1.0 and changes computed areas and spatial joins. Geometries are
  now passed to DuckDB as WKB, which is exact.
* stopped `as_dbSpatial()` and `st_join()` from changing the user's random
  number stream when naming temporary tables
* reduced memory use in `as_dbSpatial()` by reading the data frame directly
  instead of copying it into a temporary table

## Test environments

* local R 4.6.0 on x86_64-pc-linux-gnu (Ubuntu 24.04, WSL2)

## R CMD check results

`R CMD check --as-cran --no-manual` with `NOT_CRAN` unset

* 0 errors
* 0 warnings
* 0 notes

## Reverse dependencies

There are no reverse dependencies on CRAN.
