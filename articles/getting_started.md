# Getting Started

``` r

library(dbSpatial)
```

## Introduction

This vignette demonstrates how to use the
[dbSpatial](https://github.com/dbverse-org/dbspatial-r) package to
create a DuckDB database with spatial points and polygons starting from
various data sources.

All code chunks below are evaluated only when the `duckdb` package is
available and `NOT_CRAN` is `"true"`, so they are skipped on CRAN.

## Creating a DuckDB connection

``` r

# create db connection in memory
duckdb_conn = DBI::dbConnect(duckdb::duckdb(), ":memory:")
#> duckdb keeps downloaded extensions and secrets in a temporary directory:
#> ℹ /tmp/RtmpYsQQwQ/duckdb
#> This is removed when the R session ends.
#> • Extensions are re-downloaded each session.
#> • Secrets are lost.
#> ℹ Run duckdb(shared_home = TRUE) (or create ~/.duckdb) to keep them (suitable for most users).
#> ℹ Run duckdb(shared_home = FALSE) to accept the temporary directory (and silence this message).
#> ℹ See ?duckdb_storage for details and alternatives.
DBI::dbExecute(duckdb_conn, "SET threads = 1")
#> [1] 0
```

## Reading in spatial data from various sources

### From data.frames

``` r

# test data
test_data = data.frame(x = 1:10, y = 1:10, id = 1:10)

# df, tbl
# specify x and y column names to cast to a point geometry
a <- dbSpatial(conn = duckdb_conn,
               name = "test_points",
               value = test_data,
               x_colName = "x",
               y_colName = "y",
               overwrite = TRUE)
a
#> # Class:    dbSpatial 
#> # A query:  ?? x 4
#> # Database: DuckDB 2.0.0 [unknown@Linux 6.17.0-1022-azure:R 4.6.1/:memory:]
#>        x     y    id geom         
#>    <int> <int> <int> <chr>        
#>  1     1     1     1 POINT (1 1)  
#>  2     2     2     2 POINT (2 2)  
#>  3     3     3     3 POINT (3 3)  
#>  4     4     4     4 POINT (4 4)  
#>  5     5     5     5 POINT (5 5)  
#>  6     6     6     6 POINT (6 6)  
#>  7     7     7     7 POINT (7 7)  
#>  8     8     8     8 POINT (8 8)  
#>  9     9     9     9 POINT (9 9)  
#> 10    10    10    10 POINT (10 10)
```

### From .csv file

``` r

# test data
test_data = data.frame(x = 1:10, y = 1:10, id = 1:10)

# write to file
test_file <- tempfile(fileext = ".csv")
write.csv(test_data, test_file, row.names = FALSE)

# load file in db
a <- dbSpatial(conn = duckdb_conn,
               name = "test_points",
               value = test_file,
               x_colName = "x",
               y_colName = "y",
               overwrite = TRUE)
a
#> # Class:    dbSpatial 
#> # A query:  ?? x 5
#> # Database: DuckDB 2.0.0 [unknown@Linux 6.17.0-1022-azure:R 4.6.1/:memory:]
#>    OGC_FID x     y     id    geom         
#>      <dbl> <chr> <chr> <chr> <chr>        
#>  1       1 1     1     1     POINT (1 1)  
#>  2       2 2     2     2     POINT (2 2)  
#>  3       3 3     3     3     POINT (3 3)  
#>  4       4 4     4     4     POINT (4 4)  
#>  5       5 5     5     5     POINT (5 5)  
#>  6       6 6     6     6     POINT (6 6)  
#>  7       7 7     7     7     POINT (7 7)  
#>  8       8 8     8     8     POINT (8 8)  
#>  9       9 9     9     9     POINT (9 9)  
#> 10      10 10    10    10    POINT (10 10)
```

### From {terra} objects: SpatVector

``` r

# load terra package
library(terra)
#> terra 1.9.50

# Create a SpatVector from the data.frame
dummy_spatvector <- terra::vect(test_data, geom = c("x", "y"))

# Load SpatVector in db
dbSpatial(conn = duckdb_conn,
          name = "spatVector_proxy",
          value = dummy_spatvector,
          overwrite = TRUE)
#> # Class:    dbSpatial 
#> # A query:  ?? x 2
#> # Database: DuckDB 2.0.0 [unknown@Linux 6.17.0-1022-azure:R 4.6.1/:memory:]
#>       id geom         
#>    <int> <chr>        
#>  1     1 POINT (1 1)  
#>  2     2 POINT (2 2)  
#>  3     3 POINT (3 3)  
#>  4     4 POINT (4 4)  
#>  5     5 POINT (5 5)  
#>  6     6 POINT (6 6)  
#>  7     7 POINT (7 7)  
#>  8     8 POINT (8 8)  
#>  9     9 POINT (9 9)  
#> 10    10 POINT (10 10)
```
