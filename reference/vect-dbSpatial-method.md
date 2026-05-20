# Create SpatVector objects

Create SpatVector objects

## Usage

``` r
# S4 method for class 'dbSpatial'
vect(x, select = tidyselect::everything(), ...)
```

## Arguments

- x:

  A
  [`dbSpatial`](https://dbverse-org.github.io/dbspatial-r/reference/dbSpatial.md)
  object to convert into a
  [`terra::SpatVector`](https://rspatial.github.io/terra/reference/SpatVector-class.html)
  object

- select:

  Columns to retain in output (default: all columns)

- ...:

  Additional arguments passed to
  [`sf::st_as_sf`](https://r-spatial.github.io/sf/reference/st_as_sf.html)

## Value

A
[`terra::SpatVector`](https://rspatial.github.io/terra/reference/SpatVector-class.html)
containing the selected columns and geometry materialized from `x`.

## See also

Other dbSpatial:
[`as_dbSpatial()`](https://dbverse-org.github.io/dbspatial-r/reference/as_dbSpatial.md),
[`dbSpatial`](https://dbverse-org.github.io/dbspatial-r/reference/dbSpatial.md),
[`show,dbSpatial-method`](https://dbverse-org.github.io/dbspatial-r/reference/show.md),
[`st_as_sf.dbSpatial()`](https://dbverse-org.github.io/dbspatial-r/reference/st_as_sf.dbSpatial.md)

## Examples

``` r
# \donttest{
if (interactive() && requireNamespace("duckdb", quietly = TRUE)) {
  point_data <- data.frame(x = c(100, 200), y = c(500, 600), id = 1:2)
  point_vect <- terra::vect(point_data, geom = c("x", "y"))
  duckdb_conn <- DBI::dbConnect(duckdb::duckdb(), ":memory:")
  DBI::dbExecute(duckdb_conn, "SET threads = 1")
  dbs <- as_dbSpatial(point_vect, conn = duckdb_conn, name = "point_vect",
                      overwrite = TRUE)
  terra::vect(dbs)
  DBI::dbDisconnect(duckdb_conn, shutdown = TRUE)
}
# }
```
