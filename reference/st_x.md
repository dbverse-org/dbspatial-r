# Get X coordinate

Returns the X coordinate of a point.

## Usage

``` r
st_x(x, ...)

# S4 method for class 'dbSpatial'
st_x(x, ...)
```

## Arguments

- x:

  [`dbSpatial`](https://dbverse-org.github.io/dbspatial-r/reference/dbSpatial.md)
  object

- ...:

  additional arguments

## Value

[`dbSpatial`](https://dbverse-org.github.io/dbspatial-r/reference/dbSpatial.md)
object with X coordinate column

## Methods (by class)

- `st_x(dbSpatial)`: Method for `dbSpatial` objects

## See also

Other accessors:
[`st_npoints()`](https://dbverse-org.github.io/dbspatial-r/reference/st_npoints.md),
[`st_y()`](https://dbverse-org.github.io/dbspatial-r/reference/st_y.md)

## Examples

``` r
# \donttest{
if (interactive() && requireNamespace("duckdb", quietly = TRUE)) {
  point <- sf::st_sf(id = 1, geom = sf::st_sfc(sf::st_point(c(1, 2))))
  duckdb_conn <- DBI::dbConnect(duckdb::duckdb(), ":memory:")
  DBI::dbExecute(duckdb_conn, "SET threads = 1")
  x <- as_dbSpatial(point, conn = duckdb_conn, name = "point",
                    overwrite = TRUE)
  st_x(x)
  DBI::dbDisconnect(duckdb_conn, shutdown = TRUE)
}
# }
```
