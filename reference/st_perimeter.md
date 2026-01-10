# Get perimeter of geometries

Returns the perimeter of the geometry column.

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
object (lazy tibble with perimeter column)

## See also

Other measurements:
[`st_area()`](https://dbverse-org.github.io/dbspatial-r/reference/st_area.md),
[`st_length()`](https://dbverse-org.github.io/dbspatial-r/reference/st_length.md)

## Examples

``` r
if (FALSE) { # \dontrun{
st_perimeter(x)
} # }
```
