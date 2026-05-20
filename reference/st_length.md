# Get length of geometries

Returns the length of the geometry column.

## Arguments

- x:

  [`dbSpatial`](https://dbverse-org.github.io/dbspatial-r/reference/dbSpatial.md)
  object

- geomName:

  `character string`. The geometry column name. Default: `"geom"`.

- ...:

  additional arguments passed to methods

## Value

[`dbSpatial`](https://dbverse-org.github.io/dbspatial-r/reference/dbSpatial.md)
object (lazy tibble with length column)

## See also

Other measurements:
[`st_area()`](https://dbverse-org.github.io/dbspatial-r/reference/st_area.md),
[`st_perimeter()`](https://dbverse-org.github.io/dbspatial-r/reference/st_perimeter.md)

## Examples

``` r
# \donttest{
if (interactive() && requireNamespace("duckdb", quietly = TRUE)) {
  line <- sf::st_sf(
    id = 1,
    geom = sf::st_sfc(
      sf::st_linestring(rbind(c(0, 0), c(1, 1), c(2, 1)))
    )
  )
  duckdb_conn <- DBI::dbConnect(duckdb::duckdb(), ":memory:")
  DBI::dbExecute(duckdb_conn, "SET threads = 1")
  x <- as_dbSpatial(line, conn = duckdb_conn, name = "line",
                    overwrite = TRUE)
  st_length(x)
  DBI::dbDisconnect(duckdb_conn, shutdown = TRUE)
}
# }
```
