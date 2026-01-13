# Spatial Operations

``` r
library(dbSpatial)
library(sf)
#> Linking to GEOS 3.12.1, GDAL 3.8.4, PROJ 9.4.0; sf_use_s2() is TRUE
library(dplyr)
#> 
#> Attaching package: 'dplyr'
#> The following objects are masked from 'package:stats':
#> 
#>     filter, lag
#> The following objects are masked from 'package:base':
#> 
#>     intersect, setdiff, setequal, union
```

## Setup

``` r
con <- DBI::dbConnect(duckdb::duckdb(), ":memory:")

# Sample points
df <- data.frame(id = 1:3, x = c(0, 10, 20), y = c(0, 10, 20))
pts <- dbSpatial(
  conn = con, name = "pts", value = df,
  x_colName = "x", y_colName = "y", overwrite = TRUE
)
pts
#> # Class:    dbSpatial 
#> # Source:   SQL [?? x 4]
#> # Database: DuckDB 1.4.3 [unknown@Linux 6.11.0-1018-azure:R 4.5.2/:memory:]
#>      id     x     y geom         
#>   <int> <dbl> <dbl> <chr>        
#> 1     1     0     0 POINT (0 0)  
#> 2     2    10    10 POINT (10 10)
#> 3     3    20    20 POINT (20 20)
```

## Geometry Operations

``` r
# Buffer
st_buffer(pts, dist = 5)
#> # Class:    dbSpatial 
#> # Source:   SQL [?? x 4]
#> # Database: DuckDB 1.4.3 [unknown@Linux 6.11.0-1018-azure:R 4.5.2/:memory:]
#>      id     x     y geom                             
#>   <int> <dbl> <dbl> <chr>                            
#> 1     1     0     0 POLYGON ((5 0, 4.9931476737728...
#> 2     2    10    10 POLYGON ((15 10, 14.9931476737...
#> 3     3    20    20 POLYGON ((25 20, 24.9931476737...

# Centroid
st_centroid(pts)
#> # Class:    dbSpatial 
#> # Source:   SQL [?? x 4]
#> # Database: DuckDB 1.4.3 [unknown@Linux 6.11.0-1018-azure:R 4.5.2/:memory:]
#>      id     x     y geom         
#>   <int> <dbl> <dbl> <chr>        
#> 1     1     0     0 POINT (0 0)  
#> 2     2    10    10 POINT (10 10)
#> 3     3    20    20 POINT (20 20)

# Simplify
st_simplify(pts, dTolerance = 1)
#> # Class:    dbSpatial 
#> # Source:   SQL [?? x 4]
#> # Database: DuckDB 1.4.3 [unknown@Linux 6.11.0-1018-azure:R 4.5.2/:memory:]
#>      id     x     y geom         
#>   <int> <dbl> <dbl> <chr>        
#> 1     1     0     0 POINT (0 0)  
#> 2     2    10    10 POINT (10 10)
#> 3     3    20    20 POINT (20 20)
```

## Measurements

``` r
# Bounding box
st_bbox(pts)
#> xmin ymin xmax ymax 
#>    0    0   20   20

# Check validity
st_is_valid(pts)
#> # Class:    dbSpatial 
#> # Source:   SQL [?? x 4]
#> # Database: DuckDB 1.4.3 [unknown@Linux 6.11.0-1018-azure:R 4.5.2/:memory:]
#>      id     x     y geom 
#>   <int> <dbl> <dbl> <lgl>
#> 1     1     0     0 TRUE 
#> 2     2    10    10 TRUE 
#> 3     3    20    20 TRUE
```

## Spatial Joins

Use [`st_join()`](https://r-spatial.github.io/sf/reference/st_join.html)
to perform spatial joins with various predicates:

``` r
# Self-join using intersection predicate (returns joined table)
st_join(pts, pts, join = st_intersects)
#> # Class:    dbSpatial 
#> # Source:   SQL [?? x 8]
#> # Database: DuckDB 1.4.3 [unknown@Linux 6.11.0-1018-azure:R 4.5.2/:memory:]
#>      id     x     y geom           id_1   x_1   y_1 geom_1    
#>   <int> <dbl> <dbl> <chr>         <int> <dbl> <dbl> <list>    
#> 1     1     0     0 POINT (0 0)       1     0     0 <raw [32]>
#> 2     2    10    10 POINT (10 10)     2    10    10 <raw [32]>
#> 3     3    20    20 POINT (20 20)     3    20    20 <raw [32]>
```

## Convert to sf

``` r
sf_pts <- st_as_sf(pts)
sf_pts
#> Simple feature collection with 3 features and 3 fields
#> Geometry type: POINT
#> Dimension:     XY
#> Bounding box:  xmin: 0 ymin: 0 xmax: 20 ymax: 20
#> CRS:           NA
#>   id  x  y          geom
#> 1  1  0  0   POINT (0 0)
#> 2  2 10 10 POINT (10 10)
#> 3  3 20 20 POINT (20 20)
```
