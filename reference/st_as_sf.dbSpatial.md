# Convert dbSpatial objects to sf objects

S3 method implementation for converting `dbSpatial` objects to `sf`
objects.

## Usage

``` r
# S3 method for class 'dbSpatial'
st_as_sf(x, geomName = "geom", select = tidyselect::everything(), ...)
```

## Arguments

- x:

  A
  [`dbSpatial`](https://dbverse-org.github.io/dbspatial-r/reference/dbSpatial.md)
  object to convert

- geomName:

  `character string`. The geometry column name in the
  [`dbSpatial`](https://dbverse-org.github.io/dbspatial-r/reference/dbSpatial.md)
  object. Default: `"geom"`.

- select:

  Columns to retain in output (default: all columns)

- ...:

  Additional arguments passed to
  [`sf::st_read`](https://r-spatial.github.io/sf/reference/st_read.html)

## Value

An [`sf::sf`](https://r-spatial.github.io/sf/reference/sf.html) object

## Details

This method handles conversion of
[`dbSpatial`](https://dbverse-org.github.io/dbspatial-r/reference/dbSpatial.md)
to [`sf::sf`](https://r-spatial.github.io/sf/reference/sf.html) objects
using:

- Dynamic column selection via tidyselect semantics

- Automatic geometry column preservation

- SQL-level column subsetting for efficiency

## See also

Other dbSpatial:
[`as_dbSpatial()`](https://dbverse-org.github.io/dbspatial-r/reference/as_dbSpatial.md),
[`dbSpatial`](https://dbverse-org.github.io/dbspatial-r/reference/dbSpatial.md),
[`show,dbSpatial-method`](https://dbverse-org.github.io/dbspatial-r/reference/show.md),
[`vect,dbSpatial-method`](https://dbverse-org.github.io/dbspatial-r/reference/vect-dbSpatial-method.md)
