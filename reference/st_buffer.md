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
# \donttest{
if (interactive() && requireNamespace("duckdb", quietly = TRUE)) {
  point <- sf::st_sf(id = 1, geom = sf::st_sfc(sf::st_point(c(0, 0))))
  duckdb_conn <- DBI::dbConnect(duckdb::duckdb(), ":memory:")
  DBI::dbExecute(duckdb_conn, "SET threads = 1")
  x <- as_dbSpatial(point, conn = duckdb_conn, name = "point",
                    overwrite = TRUE)
  st_buffer(x, dist = 1)
  DBI::dbDisconnect(duckdb_conn, shutdown = TRUE)
}
# }
```
