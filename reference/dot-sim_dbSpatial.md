# Simulate basic dbSpatial object

Simulate basic dbSpatial object

## Usage

``` r
.sim_dbSpatial(geom = c("point", "polygon"))
```

## Arguments

- geom:

  whether to load 'point' or 'polygon' GEOMETRY test file

## Value

A dbSpatial object

## Details

Polygon data is created dynamically using sf rather than loading from
inst/extdata/polygon.geojson. This avoids issues with system.file()
returning an empty string when called from dependent packages during R
CMD check (before dbSpatial is fully installed to the test library).
