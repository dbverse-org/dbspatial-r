# dbSpatial Package Global Options

Global options to control package behavior.

## Details

Use [`options()`](https://rdrr.io/r/base/options.html) to set the below
options.

## Options

- `dbSpatial.max_print`: integer. Max characters for WKT in show method
  (default 30).

- `dbSpatial.max_mem_convert`: numeric. Max bytes for implicit coercion
  (default 8GB).

- `dbSpatial.verbose`: logical. Print info messages during coercion
  (default TRUE).

## Examples

``` r
if (FALSE) { # \dontrun{
options(dbSpatial.max_print = 50)
options(dbSpatial.max_mem_convert = 16 * 1024^3)
options(dbSpatial.verbose = FALSE)
} # }
```
