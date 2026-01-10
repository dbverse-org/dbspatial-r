# Return geometry type

This function returns the geometry type of the specified geometry column
in a
[`dbSpatial`](https://dbverse-org.github.io/dbspatial-r/reference/dbSpatial.md)
object.

## Arguments

- x:

  [`dbSpatial`](https://dbverse-org.github.io/dbspatial-r/reference/dbSpatial.md)
  object

- geomName:

  `character string`. The geometry column name in the
  [`dbSpatial`](https://dbverse-org.github.io/dbspatial-r/reference/dbSpatial.md)
  object. Default: `"geom"`.

- ...:

  additional arguments passed to methods

## Value

factor column vector in database

## See also

Other geom_scalar:
[`st_is_valid()`](https://dbverse-org.github.io/dbspatial-r/reference/st_is_valid.md)

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


st_geometry_type(x = db_points)
#> Error in st_geometry_type(x = db_points): could not find function "st_geometry_type"
```
