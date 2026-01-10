# Convert an sf or terra object to a `dbSpatial` object

Create a
[`dbSpatial`](https://dbverse-org.github.io/dbspatial-r/reference/dbSpatial.md)
object from an `sf` or `terra` object.

## Usage

``` r
as_dbSpatial(rSpatial, conn, name, overwrite = FALSE, ...)
```

## Arguments

- rSpatial:

  `sf` or `terra` object.

- conn:

  A `DBIConnection` object, as returned by
  [`DBI::dbConnect`](https://dbi.r-dbi.org/reference/dbConnect.html).

- name:

  `a character string` with the unquoted DBMS table name, e.g.
  "table_name"

- overwrite:

  `logical`. Overwrite existing table. default = FALSE.

- ...:

  Additional arguments to be passed

## Details

Writes out the `rSpatial` object to temporary .parquet file and computes
the VIEW in the database with the specified `name` and the geometry
column as `geom`.

## See also

Other dbSpatial:
[`dbSpatial`](https://dbverse-org.github.io/dbspatial-r/reference/dbSpatial.md),
[`show()`](https://dbverse-org.github.io/dbspatial-r/reference/show.md),
[`st_as_sf.dbSpatial()`](https://dbverse-org.github.io/dbspatial-r/reference/st_as_sf.dbSpatial.md),
[`vect,dbSpatial-method`](https://dbverse-org.github.io/dbspatial-r/reference/vect-dbSpatial-method.md)

## Examples

``` r
coordinates <- data.frame(x = c(100, 200, 300), y = c(500, 600, 700))
attributes <- data.frame(id = 1:3, name = c("A", "B", "C"))

# Combine the coordinates and attributes
dummy_data <- cbind(coordinates, attributes)

# Create a SpatVector from the data.frame
dummy_spatvector <- terra::vect(dummy_data, geom = c("x", "y"))

# Set db connection
duckdb_conn = DBI::dbConnect(duckdb::duckdb(), ":memory:")

dbSpatial <- as_dbSpatial(rSpatial = dummy_spatvector,
                         conn = duckdb_conn,
                         name = "dummy_spatvector",
                         overwrite = TRUE)
dbSpatial
#> # Class:    dbSpatial 
#> # Source:   SQL [?? x 3]
#> # Database: DuckDB 1.4.3 [unknown@Linux 6.11.0-1018-azure:R 4.5.2/:memory:]
#>      id name  geom           
#>   <int> <chr> <chr>          
#> 1     1 A     POINT (100 500)
#> 2     2 B     POINT (200 600)
#> 3     3 C     POINT (300 700)
```
