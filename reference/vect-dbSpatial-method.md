# Create SpatVector objects

Create SpatVector objects

## Usage

``` r
# S4 method for class 'dbSpatial'
vect(x, select = tidyselect::everything(), ...)
```

## Arguments

- x:

  A
  [`dbSpatial`](https://dbverse-org.github.io/dbspatial-r/reference/dbSpatial.md)
  object to convert into a
  [`terra::SpatVector`](https://rspatial.github.io/terra/reference/SpatVector-class.html)
  object

- select:

  Columns to retain in output (default: all columns)

- ...:

  Additional arguments passed to
  [`sf::st_as_sf`](https://r-spatial.github.io/sf/reference/st_as_sf.html)

## See also

Other dbSpatial:
[`as_dbSpatial()`](https://dbverse-org.github.io/dbspatial-r/reference/as_dbSpatial.md),
[`dbSpatial`](https://dbverse-org.github.io/dbspatial-r/reference/dbSpatial.md),
[`show()`](https://dbverse-org.github.io/dbspatial-r/reference/show.md),
[`st_as_sf.dbSpatial()`](https://dbverse-org.github.io/dbspatial-r/reference/st_as_sf.dbSpatial.md)

## Examples

``` r
dbs <- .sim_dbSpatial()
#> Error in .sim_dbSpatial(): could not find function ".sim_dbSpatial"
vect(dbs)
#> Error in h(simpleError(msg, call)): error in evaluating the argument 'x' in selecting a method for function 'vect': object 'dbs' not found
```
