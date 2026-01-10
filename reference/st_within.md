# Check if geometry A is within geometry B

Returns true if geometry A is completely inside geometry B.

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
[`st_overlaps()`](https://dbverse-org.github.io/dbspatial-r/reference/st_overlaps.md),
[`st_touches()`](https://dbverse-org.github.io/dbspatial-r/reference/st_touches.md)

## Examples

``` r
if (FALSE) { # \dontrun{
st_within(x, y)
} # }
```
