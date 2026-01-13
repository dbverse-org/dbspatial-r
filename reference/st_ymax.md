# Get maximum y coordinate

This function returns the maximum y coordinate of the geometries in the
specified
[`dbSpatial`](https://dbverse-org.github.io/dbspatial-r/reference/dbSpatial.md)
object.

## Usage

``` r
st_ymax(dbSpatial, geomName = "geom", ...)

# S4 method for class 'dbSpatial'
st_ymax(dbSpatial, geomName = "geom", ...)
```

## Arguments

- geomName:

  `character string`. The geometry column name in the
  [`dbSpatial`](https://dbverse-org.github.io/dbspatial-r/reference/dbSpatial.md)
  object. Default: `"geom"`.

- ...:

  additional arguments passed to methods

- [`dbSpatial`](https://dbverse-org.github.io/dbspatial-r/reference/dbSpatial.md):

  object

## Value

numerical column vector in database

## Functions

- `st_ymax(dbSpatial)`: Method for `dbSpatial` object

## See also

Other geom_summary:
[`st_bbox()`](https://dbverse-org.github.io/dbspatial-r/reference/st_bbox.md),
[`st_xmax()`](https://dbverse-org.github.io/dbspatial-r/reference/st_xmax.md)

## Examples

``` r
# Create a data.frame with x and y coordinates and attributes
coordinates <- data.frame(x = c(100, 200, 300), y = c(500, 600, 700))
attributes <- data.frame(id = 1:3, name = c("A", "B", "C"))

# Combine the coordinates and attributes
dummy_data <- cbind(coordinates, attributes)

# Create a duckdb connection
con = DBI::dbConnect(duckdb::duckdb(), ":memory:")

# Create a duckdb table with spatial points
db_points = dbSpatial(conn = con,
                      value = dummy_data,
                      x_colName = "x",
                      y_colName = "y",
                      name = "foo",
                      overwrite = TRUE)

st_ymax(dbSpatial = db_points)
#> [1] 700
```
