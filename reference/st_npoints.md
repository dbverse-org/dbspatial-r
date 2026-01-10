# Get number of points

Returns the number of points in a geometry.

## Usage

``` r
st_npoints(x, ...)

# S4 method for class 'dbSpatial'
st_npoints(x, ...)
```

## Arguments

- x:

  [`dbSpatial`](https://dbverse-org.github.io/dbspatial-r/reference/dbSpatial.md)
  object

- ...:

  additional arguments

## Value

[`dbSpatial`](https://dbverse-org.github.io/dbspatial-r/reference/dbSpatial.md)
object with npoints column

## Methods (by class)

- `st_npoints(dbSpatial)`: Method for `dbSpatial` objects

## See also

Other accessors:
[`st_x()`](https://dbverse-org.github.io/dbspatial-r/reference/st_x.md),
[`st_y()`](https://dbverse-org.github.io/dbspatial-r/reference/st_y.md)

## Examples

``` r
if (FALSE) { # \dontrun{
st_npoints(x)
} # }
```
