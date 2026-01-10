# Compute buffer around geometry

Returns a geometry that represents all points whose distance from this
Geometry is less than or equal to distance.

## Arguments

- x:

  [`dbSpatial`](https://dbverse-org.github.io/dbspatial-r/reference/dbSpatial.md)
  object

- dist:

  numeric distance

- ...:

  additional arguments

## Value

[`dbSpatial`](https://dbverse-org.github.io/dbspatial-r/reference/dbSpatial.md)
object with buffered geometry

## See also

Other geometry_ops:
[`st_centroid()`](https://dbverse-org.github.io/dbspatial-r/reference/st_centroid.md),
[`st_simplify()`](https://dbverse-org.github.io/dbspatial-r/reference/st_simplify.md)

## Examples

``` r
if (FALSE) { # \dontrun{
st_buffer(x, dist = 1)
} # }
```
