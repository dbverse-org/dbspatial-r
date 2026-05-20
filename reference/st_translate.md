# Translate x, y coordinates by delta x, delta y for point geometries

This function translates point geometries by the specified delta x and
delta y values.

## Usage

``` r
st_translate(dbSpatial, geomName = "geom", dx, dy, ...)

# S4 method for class 'dbSpatial'
st_translate(dbSpatial, geomName = "geom", dx, dy, ...)
```

## Arguments

- dbSpatial:

  [`dbSpatial`](https://dbverse-org.github.io/dbspatial-r/reference/dbSpatial.md)
  object.

- geomName:

  `character string`. The geometry column name in the
  [`dbSpatial`](https://dbverse-org.github.io/dbspatial-r/reference/dbSpatial.md)
  object. Default: `"geom"`.

- dx:

  `numeric`.value to shift x coordinates by

- dy:

  `numeric`. value to shift y coordinates by

- ...:

  additional arguments passed to methods

## Value

[`dbSpatial`](https://dbverse-org.github.io/dbspatial-r/reference/dbSpatial.md)
object

## Functions

- `st_translate(dbSpatial)`: Method for `dbSpatial` object

## Examples

``` r
if (interactive() && requireNamespace("duckdb", quietly = TRUE)) {
  con = DBI::dbConnect(duckdb::duckdb(), ":memory:")
  DBI::dbExecute(con, "SET threads = 1")

  coordinates <- data.frame(x = c(100, 200, 300), y = c(500, 600, 700))
  attributes <- data.frame(id = 1:3, name = c("A", "B", "C"))

  # Combine the coordinates and attributes
  dummy_data <- cbind(coordinates, attributes)

  points <- dbSpatial(conn = con,
                      name = "points",
                      value = dummy_data,
                      overwrite = TRUE,
                      x_colName = "x",
                      y_colName = "y")

  points

  points_translated <- st_translate(dbSpatial = points, dx = 100, dy = -20)

  points_translated
  DBI::dbDisconnect(con, shutdown = TRUE)
}
```
