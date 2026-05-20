# Get geometry types (DuckDB-native)

Returns the geometry type for each row in a
[dbSpatial](https://dbverse-org.github.io/dbspatial-r/reference/dbSpatial.md)
object using DuckDB's spatial function `ST_GeometryType()`.

## Usage

``` r
st_geometrytype(dbSpatial, geomName = "geom", collect = FALSE, n = NULL, ...)
```

## Arguments

- dbSpatial:

  A
  [dbSpatial](https://dbverse-org.github.io/dbspatial-r/reference/dbSpatial.md)
  object.

- geomName:

  Geometry column name. Default: `"geom"`.

- collect:

  Logical (default = `FALSE`). If `TRUE`, collect results into a
  character vector.

- n:

  Optional integer. If provided alongside `collect = TRUE`, limits the
  query to the first `n` rows before collecting.

- ...:

  Additional arguments (ignored).

## Value

If `collect = FALSE` (default), a lazy tibble with a single column
`geom_type`. If `collect = TRUE`, a character vector of geometry
type(s).
