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

  `data.frame`, `tbl_duckdb_connection`, `character` (valid file path),
  `sf` object, or `terra` object. Data to construct `dbSpatial` object
  with geometry data type. See details for more information.

- name:

  Table name.

- conn:

  A DBI connection object.

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
[`show,dbSpatial-method`](https://dbverse-org.github.io/dbspatial-r/reference/show.md),
[`st_as_sf.dbSpatial()`](https://dbverse-org.github.io/dbspatial-r/reference/st_as_sf.dbSpatial.md),
[`vect,dbSpatial-method`](https://dbverse-org.github.io/dbspatial-r/reference/vect-dbSpatial-method.md)

## Examples

``` r
if (interactive() && requireNamespace("duckdb", quietly = TRUE)) {
  # create in-memory DuckDB db
  duckdb_conn = DBI::dbConnect(duckdb::duckdb(), ":memory:")
  DBI::dbExecute(duckdb_conn, "SET threads = 1")

  # test value
  test_data = data.frame(x = 1:10, y = 1:10, id = 1:10)

  test_file <- tempfile(fileext = ".csv")
  write.csv(test_data, test_file, row.names = FALSE)

  # read data.frame and create point geometry
  dbSpatial(conn = duckdb_conn,
            name = "test_points",
            value = test_data,
            x_colName = "x",
            y_colName = "y",
            overwrite = TRUE)

  # read csv
  dbSpatial(conn = duckdb_conn,
            name = "test_points",
            value = test_file,
            x_colName = "x",
            y_colName = "y",
            overwrite = TRUE)
  unlink(test_file)
  DBI::dbDisconnect(duckdb_conn, shutdown = TRUE)
}
```
