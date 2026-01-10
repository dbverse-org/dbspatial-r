# Simplify geometry

Returns a simplified version of the given geometry using the
Douglas-Peucker algorithm.

## Arguments

- x:

  [`dbSpatial`](https://dbverse-org.github.io/dbspatial-r/reference/dbSpatial.md)
  object

- dTolerance:

  numeric tolerance

- ...:

  additional arguments

## Value

[`dbSpatial`](https://dbverse-org.github.io/dbspatial-r/reference/dbSpatial.md)
object with simplified geometry

## See also

Other geometry_ops:
[`st_buffer()`](https://dbverse-org.github.io/dbspatial-r/reference/st_buffer.md),
[`st_centroid()`](https://dbverse-org.github.io/dbspatial-r/reference/st_centroid.md)

## Examples

``` r
if (FALSE) { # \dontrun{
st_simplify(x, dTolerance = 0.1)
} # }
```
