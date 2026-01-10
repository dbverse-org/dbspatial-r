# Create a `dbSpatial` object with geometry data type

Constructor function to ingest diverse spatial data sources and create a
`dbSpatial` object containing a `geometry` data type based on the
[Simple Features](https://en.wikipedia.org/wiki/Simple_Features)
standard.

If `x_colName` and `y_colName` are both provided, a `POINT` geometry
will be constructed based on these columns.

## Usage

``` r
dbSpatial(
  value,
  name,
  conn,
  x_colName = NULL,
  y_colName = NULL,
  geomName = "geom",
  overwrite = FALSE,
  ...
)
```

## Arguments

- value:

  [`data.frame`](https://rdrr.io/r/base/data.frame.html),
  `tbl_duckdb_connection`, `character` (valid file path), `sf` object,
  or `terra` object. Data to construct `dbSpatial` object with geometry
  data type. See details for more information.

- name:

  The table name, passed on to
  [`dbQuoteIdentifier()`](https://dbi.r-dbi.org/reference/dbQuoteIdentifier.html).
  Options are:

  - a character string with the unquoted DBMS table name, e.g.
    `"table_name"`,

  - a call to [`Id()`](https://dbi.r-dbi.org/reference/Id.html) with
    components to the fully qualified table name, e.g.
    `Id(schema = "my_schema", table = "table_name")`

  - a call to [`SQL()`](https://dbi.r-dbi.org/reference/SQL.html) with
    the quoted and fully qualified table name given verbatim, e.g.
    `SQL('"my_schema"."table_name"')`

- conn:

  A DBIConnection object, as returned by
  [`dbConnect()`](https://dbi.r-dbi.org/reference/dbConnect.html).

- x_colName:

  `character`. Name of column containing numerical X coordinates.
  default = `NULL`.

- y_colName:

  `character`. Name of column containing numerical Y coordinates.
  default = `NULL`.

- geomName:

  `character string`. The geometry column name in the `dbSpatial`
  object. Default: `"geom"`.

- overwrite:

  `logical`. Overwrite existing table. default = `FALSE`.

- ...:

  Additional arguments to be passed

## Value

`dbSpatial` object.

## Details

For list of files supported see link below.
<https://DuckDB.org/docs/extensions/spatial.html#st_read---read-spatial-value-from-files>

## See also

Other dbSpatial:
[`as_dbSpatial()`](https://dbverse-org.github.io/dbspatial-r/reference/as_dbSpatial.md),
[`show()`](https://dbverse-org.github.io/dbspatial-r/reference/show.md),
[`st_as_sf.dbSpatial()`](https://dbverse-org.github.io/dbspatial-r/reference/st_as_sf.dbSpatial.md),
[`vect,dbSpatial-method`](https://dbverse-org.github.io/dbspatial-r/reference/vect-dbSpatial-method.md)

## Examples

``` r
# create in-memory DuckDB db
duckdb_conn = DBI::dbConnect(duckdb::duckdb(), ":memory:")

# test value
test_data = data.frame(x = 1:10, y = 1:10, id = 1:10)

write.csv(test_data, "test_data.csv", row.names = FALSE)

# read data.frame and create point geometry
dbSpatial(conn = duckdb_conn,
          name = "test_points",
          value = test_data,
          x_colName = "x",
          y_colName = "y",
          overwrite = TRUE)
#> # Class:    dbSpatial 
#> # Source:   SQL [?? x 4]
#> # Database: DuckDB 1.4.3 [unknown@Linux 6.11.0-1018-azure:R 4.5.2/:memory:]
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

# read csv
dbSpatial(conn = duckdb_conn,
          name = "test_points",
          value = 'test_data.csv',
          x_colName = "x",
          y_colName = "y",
          overwrite = TRUE)
#> # Class:    dbSpatial 
#> # Source:   SQL [?? x 4]
#> # Database: DuckDB 1.4.3 [unknown@Linux 6.11.0-1018-azure:R 4.5.2/:memory:]
#>    x     y     id    geom         
#>    <chr> <chr> <chr> <chr>        
#>  1 1     1     1     POINT (1 1)  
#>  2 2     2     2     POINT (2 2)  
#>  3 3     3     3     POINT (3 3)  
#>  4 4     4     4     POINT (4 4)  
#>  5 5     5     5     POINT (5 5)  
#>  6 6     6     6     POINT (6 6)  
#>  7 7     7     7     POINT (7 7)  
#>  8 8     8     8     POINT (8 8)  
#>  9 9     9     9     POINT (9 9)  
#> 10 10    10    10    POINT (10 10)
```
