# Get number of points

Returns the number of points in a geometry.

## Usage

``` r
st_npoints(x, ...)

# S4 method for class 'dbSpatial'
st_npoints(x, ...)
```

## Arguments

- x:

  [`dbSpatial`](https://dbverse-org.github.io/dbspatial-r/reference/dbSpatial.md)
  object

- ...:

  additional arguments

## Value

[`dbSpatial`](https://dbverse-org.github.io/dbspatial-r/reference/dbSpatial.md)
object with npoints column

## Methods (by class)

- `st_npoints(dbSpatial)`: Method for `dbSpatial` objects

## See also

Other accessors:
[`st_x()`](https://dbverse-org.github.io/dbspatial-r/reference/st_x.md),
[`st_y()`](https://dbverse-org.github.io/dbspatial-r/reference/st_y.md)

## Examples

``` r
# \donttest{
if (interactive() && requireNamespace("duckdb", quietly = TRUE)) {
  line <- sf::st_sf(
    id = 1,
    geom = sf::st_sfc(sf::st_linestring(rbind(c(0, 0), c(1, 1), c(2, 1))))
  )
  duckdb_conn <- DBI::dbConnect(duckdb::duckdb(), ":memory:")
  DBI::dbExecute(duckdb_conn, "SET threads = 1")
  x <- as_dbSpatial(line, conn = duckdb_conn, name = "line",
                    overwrite = TRUE)
  st_npoints(x)
  DBI::dbDisconnect(duckdb_conn, shutdown = TRUE)
}
# }
```
