# Compute bounding box for dbSpatial object

Returns the bounding box of the geometry column.

## Usage

``` r
# S3 method for class 'dbSpatial'
st_bbox(obj, ...)
```

## Arguments

- obj:

  [`dbSpatial`](https://dbverse-org.github.io/dbspatial-r/reference/dbSpatial.md)
  object

- ...:

  additional arguments passed to methods

## Value

`bbox` object (named numeric vector with xmin, ymin, xmax, ymax)

## See also

Other geom_summary:
[`st_xmax()`](https://dbverse-org.github.io/dbspatial-r/reference/st_xmax.md),
[`st_ymax()`](https://dbverse-org.github.io/dbspatial-r/reference/st_ymax.md)
