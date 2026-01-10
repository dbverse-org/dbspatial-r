# Convert to GeoJSON

Returns the GeoJSON representation of the geometry.

## Usage

``` r
st_as_geojson(x, ...)

# S3 method for class 'dbSpatial'
st_as_geojson(x, ...)
```

## Arguments

- x:

  [`dbSpatial`](https://dbverse-org.github.io/dbspatial-r/reference/dbSpatial.md)
  object

- ...:

  additional arguments

## Value

[`dbSpatial`](https://dbverse-org.github.io/dbspatial-r/reference/dbSpatial.md)
object with GeoJSON column

## Functions

- `st_as_geojson(dbSpatial)`: Method for `dbSpatial` objects

## See also

Other constructors:
[`st_as_text()`](https://dbverse-org.github.io/dbspatial-r/reference/st_as_text.md)

## Examples

``` r
if (FALSE) { # \dontrun{
st_as_geojson(x)
} # }
```
