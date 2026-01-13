# Spatial join for dbSpatial objects

Performs a spatial join between two dbSpatial objects using a specified
spatial predicate function.

## Usage

``` r
# S3 method for class 'dbSpatial'
st_join(x, y, join = st_intersects, suffix = c(".x", ".y"), ...)
```

## Arguments

- x:

  A
  [`dbSpatial`](https://dbverse-org.github.io/dbspatial-r/reference/dbSpatial.md)
  object.

- y:

  A
  [`dbSpatial`](https://dbverse-org.github.io/dbspatial-r/reference/dbSpatial.md)
  object.

- join:

  Spatial predicate function to use for the join. Default is
  `st_intersects`. Supported predicates: `st_intersects`, `st_contains`,
  `st_within`, `st_covers`, `st_covered_by`, `st_crosses`,
  `st_disjoint`, `st_equals`, `st_touches`, `st_overlaps`.

- suffix:

  Character vector of length 2. Suffixes to add to duplicate column
  names from x and y. Default is `c(".x", ".y")`.

- ...:

  Additional arguments passed to the internal join function.

## Value

A
[`dbSpatial`](https://dbverse-org.github.io/dbspatial-r/reference/dbSpatial.md)
object containing the spatial join result.

## Details

This function follows the `sf` pattern where spatial predicates are
passed as the `join` argument.

## Examples

``` r
if (FALSE) { # \dontrun{
con <- DBI::dbConnect(duckdb::duckdb(), ":memory:")

df1 <- data.frame(id = 1:3, x = c(0, 10, 20), y = c(0, 10, 20))
pts1 <- dbSpatial(conn = con, name = "pts1", value = df1,
                  x_colName = "x", y_colName = "y", overwrite = TRUE)

df2 <- data.frame(id = 4:6, x = c(0, 15, 25), y = c(0, 15, 25))
pts2 <- dbSpatial(conn = con, name = "pts2", value = df2,
                  x_colName = "x", y_colName = "y", overwrite = TRUE)

# Spatial join using intersection
result <- st_join(pts1, pts2, join = st_intersects)

# Spatial join using within predicate
result <- st_join(pts1, pts2, join = st_within)

DBI::dbDisconnect(con, shutdown = TRUE)
} # }
```
