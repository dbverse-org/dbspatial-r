# Get Y coordinate

Returns the Y coordinate of a point.

## Usage

``` r
st_y(x, ...)

# S4 method for class 'dbSpatial'
st_y(x, ...)
```

## Arguments

- x:

  [`dbSpatial`](https://dbverse-org.github.io/dbspatial-r/reference/dbSpatial.md)
  object

- ...:

  additional arguments

## Value

[`dbSpatial`](https://dbverse-org.github.io/dbspatial-r/reference/dbSpatial.md)
object with Y coordinate column

## Methods (by class)

- `st_y(dbSpatial)`: Method for `dbSpatial` objects

## See also

Other accessors:
[`st_npoints()`](https://dbverse-org.github.io/dbspatial-r/reference/st_npoints.md),
[`st_x()`](https://dbverse-org.github.io/dbspatial-r/reference/st_x.md)

## Examples

``` r
# \donttest{
if (interactive() && requireNamespace("duckdb", quietly = TRUE)) {
  point <- sf::st_sf(id = 1, geom = sf::st_sfc(sf::st_point(c(1, 2))))
  duckdb_conn <- DBI::dbConnect(duckdb::duckdb(), ":memory:")
  DBI::dbExecute(duckdb_conn, "SET threads = 1")
  x <- as_dbSpatial(point, conn = duckdb_conn, name = "point",
                    overwrite = TRUE)
  st_y(x)
  DBI::dbDisconnect(duckdb_conn, shutdown = TRUE)
}
# }
```
