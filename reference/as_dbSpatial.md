# Convert an sf or terra object to a `dbSpatial` object

Create a
[`dbSpatial`](https://dbverse-org.github.io/dbspatial-r/reference/dbSpatial.md)
object from an `sf` or `terra` object.

## Usage

``` r
as_dbSpatial(rSpatial, conn, name, overwrite = FALSE, temporary = TRUE, ...)
```

## Arguments

- rSpatial:

  `sf` or `terra` object.

- conn:

  A DBI connection object, as returned by
  [`DBI::dbConnect()`](https://dbi.r-dbi.org/reference/dbConnect.html).

- name:

  `a character string` with the unquoted DBMS table name, e.g.
  "table_name"

- overwrite:

  `logical`. Overwrite existing table. default = FALSE.

- temporary:

  `logical`. Create a temporary table. default = TRUE.

- ...:

  Additional arguments to be passed

## Value

A
[`dbSpatial`](https://dbverse-org.github.io/dbspatial-r/reference/dbSpatial.md)
object backed by table `name` in `conn`, with the geometry column stored
as `geom`.

## Details

Writes the `rSpatial` object to a temporary DuckDB table and computes
the table in the database with the specified `name` and the geometry
column as `geom`.

## See also

Other dbSpatial:
[`dbSpatial`](https://dbverse-org.github.io/dbspatial-r/reference/dbSpatial.md),
[`show,dbSpatial-method`](https://dbverse-org.github.io/dbspatial-r/reference/show.md),
[`st_as_sf.dbSpatial()`](https://dbverse-org.github.io/dbspatial-r/reference/st_as_sf.dbSpatial.md),
[`vect,dbSpatial-method`](https://dbverse-org.github.io/dbspatial-r/reference/vect-dbSpatial-method.md)

## Examples

``` r
if (interactive() && requireNamespace("duckdb", quietly = TRUE)) {
  coordinates <- data.frame(x = c(100, 200, 300), y = c(500, 600, 700))
  attributes <- data.frame(id = 1:3, name = c("A", "B", "C"))

  # Combine the coordinates and attributes
  dummy_data <- cbind(coordinates, attributes)

  # Create a SpatVector from the data.frame
  dummy_spatvector <- terra::vect(dummy_data, geom = c("x", "y"))

  # Set db connection
  duckdb_conn = DBI::dbConnect(duckdb::duckdb(), ":memory:")
  DBI::dbExecute(duckdb_conn, "SET threads = 1")

  dbSpatial <- as_dbSpatial(rSpatial = dummy_spatvector,
                           conn = duckdb_conn,
                           name = "dummy_spatvector",
                           overwrite = TRUE)
  dbSpatial
  DBI::dbDisconnect(duckdb_conn, shutdown = TRUE)
}
```
