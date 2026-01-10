# Ingest spatial data from a file as a `VIEW` and create a `dbSpatial` object

Ingest spatial data from a file as a `VIEW` and create a `dbSpatial`
object

## Usage

``` r
.st_read(
  conn,
  name,
  value,
  x_colName = NULL,
  y_colName = NULL,
  geomName = "geom",
  overwrite = FALSE,
  return = TRUE,
  ...
)
```

## Arguments

- conn:

  a duckdb connection

- name:

  name of the table to be created

- value:

  a data.frame or a file path

- x_colName:

  name of the column containing x coordinates. default: 'NULL'

- y_colName:

  name of the column containing y coordinates. default: 'NULL'

- geomName:

  name of the geometry column to be created. default: 'geom'

- overwrite:

  logical; if TRUE, overwrite the table if it already exists default:
  'FALSE'

- return:

  return dbSpatial object. default: 'FALSE'

- ...:

  additional arguments to pass to st_read

## Value

`dbSpatial` object if `return = TRUE` else `NULL`

## Details

For list of files supported see the documentation below.
<https://DuckDB.org/docs/extensions/spatial.html#st_read---read-spatial-value-from-files>
