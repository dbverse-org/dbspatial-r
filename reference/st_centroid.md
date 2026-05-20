# Compute centroid of geometry

Returns the geometric center of a geometry.

## Arguments

- x:

  [`dbSpatial`](https://dbverse-org.github.io/dbspatial-r/reference/dbSpatial.md)
  object

- ...:

  additional arguments

## Value

[`dbSpatial`](https://dbverse-org.github.io/dbspatial-r/reference/dbSpatial.md)
object with centroid geometry

## See also

Other geometry_ops:
[`st_buffer()`](https://dbverse-org.github.io/dbspatial-r/reference/st_buffer.md),
[`st_simplify()`](https://dbverse-org.github.io/dbspatial-r/reference/st_simplify.md)

## Examples

``` r
# \donttest{
if (interactive() && requireNamespace("duckdb", quietly = TRUE)) {
  square <- sf::st_sf(
    id = 1,
    geom = sf::st_sfc(
      sf::st_polygon(list(rbind(
        c(0, 0), c(1, 0), c(1, 1), c(0, 1), c(0, 0)
      )))
    )
  )
  duckdb_conn <- DBI::dbConnect(duckdb::duckdb(), ":memory:")
  DBI::dbExecute(duckdb_conn, "SET threads = 1")
  x <- as_dbSpatial(square, conn = duckdb_conn, name = "square",
                    overwrite = TRUE)
  st_centroid(x)
  DBI::dbDisconnect(duckdb_conn, shutdown = TRUE)
}
# }
```
