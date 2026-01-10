# Determine if geometries in two [`dbSpatial`](https://dbverse-org.github.io/dbspatial-r/reference/dbSpatial.md) objects cover each other

https://postgis.net/docs/ST_Covers.html

## Arguments

- name:

  `character`. Default: "covers_geom"

## Value

[`dbSpatial`](https://dbverse-org.github.io/dbspatial-r/reference/dbSpatial.md)
object

## See also

Other spatial_join:
[`st_contains()`](https://dbverse-org.github.io/dbspatial-r/reference/st_contains.md),
[`st_covered_by()`](https://dbverse-org.github.io/dbspatial-r/reference/st_covered_by.md),
[`st_crosses()`](https://dbverse-org.github.io/dbspatial-r/reference/st_crosses.md),
[`st_disjoint()`](https://dbverse-org.github.io/dbspatial-r/reference/st_disjoint.md),
[`st_equals()`](https://dbverse-org.github.io/dbspatial-r/reference/st_equals.md),
[`st_intersects()`](https://dbverse-org.github.io/dbspatial-r/reference/st_intersects.md),
[`st_is_within_distance()`](https://dbverse-org.github.io/dbspatial-r/reference/st_is_within_distance.md),
[`st_overlaps()`](https://dbverse-org.github.io/dbspatial-r/reference/st_overlaps.md),
[`st_touches()`](https://dbverse-org.github.io/dbspatial-r/reference/st_touches.md),
[`st_within()`](https://dbverse-org.github.io/dbspatial-r/reference/st_within.md)

## Examples

``` r
con = DBI::dbConnect(duckdb::duckdb(), ":memory:")

coordinates <- data.frame(x = c(100, 200, 300), y = c(500, 600, 700))
attributes <- data.frame(id = 1:3, name = c("A1", "B1", "C1"))

# Combine the coordinates and attributes
dummy_data <- cbind(coordinates, attributes)

points <- dbSpatial(conn = con,
                    name = "points",
                    value = dummy_data,
                    overwrite = TRUE,
                    x_colName = "x",
                    y_colName = "y")

# preview
points
#> # Class:    dbSpatial 
#> # Source:   SQL [?? x 5]
#> # Database: DuckDB 1.4.3 [unknown@Linux 6.11.0-1018-azure:R 4.5.2/:memory:]
#>       x     y    id name  geom           
#>   <dbl> <dbl> <int> <chr> <chr>          
#> 1   100   500     1 A1    POINT (100 500)
#> 2   200   600     2 B1    POINT (200 600)
#> 3   300   700     3 C1    POINT (300 700)

# Create a second set of points, with B1 and C1 translated by + 100
dummy_data2 <- dummy_data
dummy_data2[c(2,3),c(1,2)] <- dummy_data2[c(2,3),c(1,2)] + 150
dummy_data2$name <- c('A2', 'B2', 'C2')

points2 <- dbSpatial(conn = con,
                     name = "points2",
                     value = dummy_data2,
                     overwrite = TRUE,
                     x_colName = "x",
                     y_colName = "y")
# preview
points2
#> # Class:    dbSpatial 
#> # Source:   SQL [?? x 5]
#> # Database: DuckDB 1.4.3 [unknown@Linux 6.11.0-1018-azure:R 4.5.2/:memory:]
#>       x     y    id name  geom           
#>   <dbl> <dbl> <int> <chr> <chr>          
#> 1   100   500     1 A2    POINT (100 500)
#> 2   350   750     2 B2    POINT (350 750)
#> 3   450   850     3 C2    POINT (450 850)

res <- st_covers(x = points,
                 y = points2,
                 overwrite = TRUE)
#> Error in st_covers(x = points, y = points2, overwrite = TRUE): could not find function "st_covers"

res
#> Error: object 'res' not found
```
