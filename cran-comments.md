## Resubmission

This is a resubmission. In response to the previous CRAN feedback, I:

* fixed `as_dbSpatial(..., temporary = FALSE)` so it creates persistent
  database tables as documented

## Test environments

* local R 4.5.2 on x86_64-pc-linux-gnu (AlmaLinux 8.10)

## R CMD check results

`R CMD check --as-cran --no-manual --ignore-vignettes`

* 0 errors
* 0 warnings
* 2 notes: days since last update / no prebuilt vignette index; local Pandoc not
  installed for checking `README.md` and `NEWS.md`
