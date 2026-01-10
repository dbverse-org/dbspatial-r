# Check if geometries overlap

Returns true if the Geometries share space, are of the same dimension,
but are not completely contained by each other.

## Arguments

- x:

  [`dbSpatial`](https://dbverse-org.github.io/dbspatial-r/reference/dbSpatial.md)
  object

- y:

  [`dbSpatial`](https://dbverse-org.github.io/dbspatial-r/reference/dbSpatial.md)
  object

- ...:

  additional arguments

## Value

[`dbSpatial`](https://dbverse-org.github.io/dbspatial-r/reference/dbSpatial.md)
object (view) with predicate result

## See also

Other spatial_join:
[`st_contains()`](https://dbverse-org.github.io/dbspatial-r/reference/st_contains.md),
[`st_covered_by()`](https://dbverse-org.github.io/dbspatial-r/reference/st_covered_by.md),
[`st_covers()`](https://dbverse-org.github.io/dbspatial-r/reference/st_covers.md),
[`st_crosses()`](https://dbverse-org.github.io/dbspatial-r/reference/st_crosses.md),
[`st_disjoint()`](https://dbverse-org.github.io/dbspatial-r/reference/st_disjoint.md),
[`st_equals()`](https://dbverse-org.github.io/dbspatial-r/reference/st_equals.md),
[`st_intersects()`](https://dbverse-org.github.io/dbspatial-r/reference/st_intersects.md),
[`st_is_within_distance()`](https://dbverse-org.github.io/dbspatial-r/reference/st_is_within_distance.md),
[`st_touches()`](https://dbverse-org.github.io/dbspatial-r/reference/st_touches.md),
[`st_within()`](https://dbverse-org.github.io/dbspatial-r/reference/st_within.md)

## Examples

``` r
if (FALSE) { # \dontrun{
st_overlaps(x, y)
} # }
```
