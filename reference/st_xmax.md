# Get maximum x coordinate

This function returns the maximum x coordinate in each `geometry` in the
specified
[`dbSpatial`](https://dbverse-org.github.io/dbspatial-r/reference/dbSpatial.md)
object.

## Usage

``` r
st_xmax(dbSpatial, geomName = "geom", ...)

# S4 method for class 'dbSpatial'
st_xmax(dbSpatial, geomName = "geom", ...)
```

## Arguments

- dbSpatial:

  [`dbSpatial`](https://dbverse-org.github.io/dbspatial-r/reference/dbSpatial.md)
  object.

- geomName:

  `character string`. The geometry column name in the
  [`dbSpatial`](https://dbverse-org.github.io/dbspatial-r/reference/dbSpatial.md)
  object. Default: `"geom"`.

- ...:

  additional arguments passed to methods

## Value

numerical column vector in database

## Functions

- `st_xmax(dbSpatial)`: Method for `dbSpatial` object

## See also

Other geom_summary:
[`st_bbox()`](https://dbverse-org.github.io/dbspatial-r/reference/st_bbox.md),
[`st_ymax()`](https://dbverse-org.github.io/dbspatial-r/reference/st_ymax.md)

## Examples

``` r
if (interactive() && requireNamespace("duckdb", quietly = TRUE)) {
  # Create a data.frame with x and y coordinates and attributes
  coordinates <- data.frame(x = c(100, 200, 300), y = c(500, 600, 700))
  attributes <- data.frame(id = 1:3, name = c("A", "B", "C"))

  # Combine the coordinates and attributes
  dummy_data <- cbind(coordinates, attributes)

  # Create a duckdb connection
  con = DBI::dbConnect(duckdb::duckdb(), ":memory:")
  DBI::dbExecute(con, "SET threads = 1")

  # Create a duckdb table with spatial points
  db_points = dbSpatial(conn = con,
                        value = dummy_data,
                        x_colName = "x",
                        y_colName = "y",
                        name = "foo",
                        overwrite = TRUE)

  st_xmax(dbSpatial = db_points)
  DBI::dbDisconnect(con, shutdown = TRUE)
}
```
