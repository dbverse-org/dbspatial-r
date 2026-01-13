# Get geometry types (DuckDB-native)

Returns the geometry type for each row in a
[dbSpatial](https://dbverse-org.github.io/dbspatial-r/reference/dbSpatial.md)
object using DuckDB's spatial function `ST_GeometryType()`.

## Usage

``` r
st_geometrytype(dbSpatial, geomName = "geom", ...)
```

## Arguments

- dbSpatial:

  A
  [dbSpatial](https://dbverse-org.github.io/dbspatial-r/reference/dbSpatial.md)
  object.

- geomName:

  Geometry column name. Default: `"geom"`.

- ...:

  Additional arguments (ignored).

## Value

A lazy tibble with a single column `geom_type`.
