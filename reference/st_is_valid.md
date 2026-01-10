# Determine if geometry is valid

This function returns whether the specified geometry column in the
specified
[`dbSpatial`](https://dbverse-org.github.io/dbspatial-r/reference/dbSpatial.md)
object is valid or not.

## Arguments

- x:

  [`dbSpatial`](https://dbverse-org.github.io/dbspatial-r/reference/dbSpatial.md)
  object

- geomName:

  `character string`. The geometry column name in the
  [`dbSpatial`](https://dbverse-org.github.io/dbspatial-r/reference/dbSpatial.md)
  object. Default: `"geom"`.

- ...:

  additional arguments passed to methods

## Value

boolean column vector in database

## See also

Other geom_scalar:
[`st_geometry_type()`](https://dbverse-org.github.io/dbspatial-r/reference/st_geometry_type.md)

## Examples

``` r
# ...
```
