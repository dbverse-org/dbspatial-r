# Install and/or load DuckDB spatial extension

Install and/or load DuckDB spatial extension

## Usage

``` r
loadSpatial(conn)
```

## Arguments

- conn:

  duckdb connection

## Value

No return value, called for side effects. Installs and loads the DuckDB
spatial extension for `conn`.

## Examples

``` r
if (interactive() && requireNamespace("duckdb", quietly = TRUE)) {
  duckdb_conn = DBI::dbConnect(duckdb::duckdb(), ":memory:")
  DBI::dbExecute(duckdb_conn, "SET threads = 1")
  loadSpatial(conn = duckdb_conn)
  DBI::dbDisconnect(duckdb_conn, shutdown = TRUE)
}
```
