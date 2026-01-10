# Get area of geometries

Returns the area of the geometry column.

## Arguments

- x:

  [`dbSpatial`](https://dbverse-org.github.io/dbspatial-r/reference/dbSpatial.md)
  object

- geomName:

  `character string`. The geometry column name. Default: `"geom"`.

- ...:

  additional arguments passed to methods

## Value

[`dbSpatial`](https://dbverse-org.github.io/dbspatial-r/reference/dbSpatial.md)
object (lazy tibble with area column)

## See also

Other measurements:
[`st_length()`](https://dbverse-org.github.io/dbspatial-r/reference/st_length.md),
[`st_perimeter()`](https://dbverse-org.github.io/dbspatial-r/reference/st_perimeter.md)

## Examples

``` r
if (FALSE) { # \dontrun{
st_area(x)
} # }
```
