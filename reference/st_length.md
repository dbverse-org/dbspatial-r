# Get length of geometries

Returns the length of the geometry column.

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
object (lazy tibble with length column)

## See also

Other measurements:
[`st_area()`](https://dbverse-org.github.io/dbspatial-r/reference/st_area.md),
[`st_perimeter()`](https://dbverse-org.github.io/dbspatial-r/reference/st_perimeter.md)

## Examples

``` r
if (FALSE) { # \dontrun{
st_length(x)
} # }
```
