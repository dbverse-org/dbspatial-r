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

- [`dbSpatial`](https://dbverse-org.github.io/dbspatial-r/reference/dbSpatial.md):

  object

- name:

  `string.` name of table to add to
  [`dbSpatial`](https://dbverse-org.github.io/dbspatial-r/reference/dbSpatial.md)
  object.

## Value

[`dbSpatial`](https://dbverse-org.github.io/dbspatial-r/reference/dbSpatial.md)
object

## Functions

- `st_translate(dbSpatial)`: Method for `dbSpatial` object

## Examples

``` r
con = DBI::dbConnect(duckdb::duckdb(), ":memory:")

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
#> # Class:    dbSpatial 
#> # Source:   SQL [?? x 5]
#> # Database: DuckDB 1.4.3 [unknown@Linux 6.11.0-1018-azure:R 4.5.2/:memory:]
#>       x     y    id name  geom           
#>   <dbl> <dbl> <int> <chr> <chr>          
#> 1   100   500     1 A     POINT (100 500)
#> 2   200   600     2 B     POINT (200 600)
#> 3   300   700     3 C     POINT (300 700)

points_translated <- st_translate(dbSpatial = points, dx = 100, dy = -20)

points_translated
#> # Class:    dbSpatial 
#> # Source:   SQL [?? x 5]
#> # Database: DuckDB 1.4.3 [unknown@Linux 6.11.0-1018-azure:R 4.5.2/:memory:]
#>       x     y    id name  geom           
#>   <dbl> <dbl> <int> <chr> <chr>          
#> 1   100   500     1 A     POINT (200 480)
#> 2   200   600     2 B     POINT (300 580)
#> 3   300   700     3 C     POINT (400 680)
```
