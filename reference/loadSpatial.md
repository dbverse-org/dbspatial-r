# Install and/or load DuckDB spatial extension

Install and/or load DuckDB spatial extension

## Usage

``` r
loadSpatial(conn)
```

## Arguments

- conn:

  duckdb connection

## Examples

``` r
duckdb_conn = DBI::dbConnect(duckdb::duckdb(), ":memory:")
loadSpatial(conn = duckdb_conn)
#> DuckDB spatial extension installed and loaded
```
