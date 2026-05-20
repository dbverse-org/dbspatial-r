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
# \donttest{
if (interactive() && requireNamespace("duckdb", quietly = TRUE)) {
  line <- sf::st_sf(
    id = 1,
    geom = sf::st_sfc(
      sf::st_linestring(rbind(
        c(0, 0), c(0.5, 0.2), c(1, 0), c(1.5, 0.1), c(2, 0)
      ))
    )
  )
  duckdb_conn <- DBI::dbConnect(duckdb::duckdb(), ":memory:")
  DBI::dbExecute(duckdb_conn, "SET threads = 1")
  x <- as_dbSpatial(line, conn = duckdb_conn, name = "line",
                    overwrite = TRUE)
  st_simplify(x, dTolerance = 0.1)
  DBI::dbDisconnect(duckdb_conn, shutdown = TRUE)
}
# }
```
