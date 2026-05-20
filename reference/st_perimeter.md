# Get perimeter of geometries

Returns the perimeter of the geometry column.

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
object (lazy tibble with perimeter column)

## See also

Other measurements:
[`st_area()`](https://dbverse-org.github.io/dbspatial-r/reference/st_area.md),
[`st_length()`](https://dbverse-org.github.io/dbspatial-r/reference/st_length.md)

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
  st_perimeter(x)
  DBI::dbDisconnect(duckdb_conn, shutdown = TRUE)
}
# }
```
