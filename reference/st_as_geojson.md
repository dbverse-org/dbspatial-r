# Convert to GeoJSON

Returns the GeoJSON representation of the geometry.

## Usage

``` r
st_as_geojson(x, ...)

# S3 method for class 'dbSpatial'
st_as_geojson(x, ...)
```

## Arguments

- x:

  [`dbSpatial`](https://dbverse-org.github.io/dbspatial-r/reference/dbSpatial.md)
  object

- ...:

  additional arguments

## Value

[`dbSpatial`](https://dbverse-org.github.io/dbspatial-r/reference/dbSpatial.md)
object with GeoJSON column

## Functions

- `st_as_geojson(dbSpatial)`: Method for `dbSpatial` objects

## See also

Other constructors:
[`st_as_text()`](https://dbverse-org.github.io/dbspatial-r/reference/st_as_text.md)

## Examples

``` r
# \donttest{
if (interactive() && requireNamespace("duckdb", quietly = TRUE)) {
  point <- sf::st_sf(id = 1, geom = sf::st_sfc(sf::st_point(c(1, 2))))
  duckdb_conn <- DBI::dbConnect(duckdb::duckdb(), ":memory:")
  DBI::dbExecute(duckdb_conn, "SET threads = 1")
  x <- as_dbSpatial(point, conn = duckdb_conn, name = "point",
                    overwrite = TRUE)
  st_as_geojson(x)
  DBI::dbDisconnect(duckdb_conn, shutdown = TRUE)
}
# }
```
