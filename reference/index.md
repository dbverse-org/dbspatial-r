# Package index

## dbSpatial Package

Functions and methods for `dbSpatial` objects

- [`as_dbSpatial()`](https://dbverse-org.github.io/dbspatial-r/reference/as_dbSpatial.md)
  :

  Convert an sf or terra object to a `dbSpatial` object

- [`dbSpatial()`](https://dbverse-org.github.io/dbspatial-r/reference/dbSpatial.md)
  :

  Create a `dbSpatial` object with geometry data type

- [`show(`*`<dbSpatial>`*`)`](https://dbverse-org.github.io/dbspatial-r/reference/show.md)
  : show method for dbSpatial

- [`st_as_sf(`*`<dbSpatial>`*`)`](https://dbverse-org.github.io/dbspatial-r/reference/st_as_sf.dbSpatial.md)
  : Convert dbSpatial objects to sf objects

- [`vect(`*`<dbSpatial>`*`)`](https://dbverse-org.github.io/dbspatial-r/reference/vect-dbSpatial-method.md)
  : Create SpatVector objects

## Spatial Joins

Functions and methods that perform a spatial join between `dbSpatial`
objects.

- [`st_join(`*`<dbSpatial>`*`)`](https://dbverse-org.github.io/dbspatial-r/reference/st_join.dbSpatial.md)
  : Spatial join for dbSpatial objects

## Spatial Summary

Functions and methods that summarize geometry data in a `dbSpatial`
object.

- [`st_bbox(`*`<dbSpatial>`*`)`](https://dbverse-org.github.io/dbspatial-r/reference/st_bbox.md)
  : Compute bounding box for dbSpatial object
- [`st_xmax()`](https://dbverse-org.github.io/dbspatial-r/reference/st_xmax.md)
  : Get maximum x coordinate
- [`st_ymax()`](https://dbverse-org.github.io/dbspatial-r/reference/st_ymax.md)
  : Get maximum y coordinate

## Spatial Properties

Functions and methods that return a single vector about a geometry in a
`dbSpatial` object.

- [`st_geometrytype()`](https://dbverse-org.github.io/dbspatial-r/reference/st_geometrytype.md)
  : Get geometry types (DuckDB-native)

## Geometry construction

Functions and methods for constructing or modifying geometry in a
`dbSpatial` object.

- [`st_translate()`](https://dbverse-org.github.io/dbspatial-r/reference/st_translate.md)
  : Translate x, y coordinates by delta x, delta y for point geometries
- [`st_as_geojson()`](https://dbverse-org.github.io/dbspatial-r/reference/st_as_geojson.md)
  : Convert to GeoJSON
- [`st_as_text`](https://dbverse-org.github.io/dbspatial-r/reference/st_as_text.md)
  : Convert to WKT

## DuckDB Spatial Extension

Functions and methods specific for DuckDB spatial extension.

- [`loadSpatial()`](https://dbverse-org.github.io/dbspatial-r/reference/loadSpatial.md)
  : Install and/or load DuckDB spatial extension

## dbData

dbData methods

- [`head(`*`<dbSpatial>`*`)`](https://dbverse-org.github.io/dbspatial-r/reference/head.md)
  : head method for dbSpatial
- [`tail(`*`<dbSpatial>`*`)`](https://dbverse-org.github.io/dbspatial-r/reference/tail.md)
  : tail method for dbSpatial

## Geometry Operations

Functions that modify or transform geometries.

- [`st_buffer`](https://dbverse-org.github.io/dbspatial-r/reference/st_buffer.md)
  : Compute buffer around geometry
- [`st_centroid`](https://dbverse-org.github.io/dbspatial-r/reference/st_centroid.md)
  : Compute centroid of geometry
- [`st_simplify`](https://dbverse-org.github.io/dbspatial-r/reference/st_simplify.md)
  : Simplify geometry

## Measurements

Functions that compute metric measurements of geometries.

- [`st_area`](https://dbverse-org.github.io/dbspatial-r/reference/st_area.md)
  : Get area of geometries
- [`st_length`](https://dbverse-org.github.io/dbspatial-r/reference/st_length.md)
  : Get length of geometries
- [`st_perimeter`](https://dbverse-org.github.io/dbspatial-r/reference/st_perimeter.md)
  : Get perimeter of geometries

## Accessors

Functions that extract coordinates or properties.

- [`` `$`( ``*`<dbSpatial>`*`)`](https://dbverse-org.github.io/dbspatial-r/reference/cash-dbSpatial-method.md)
  : Column extraction for dbSpatial
- [`st_npoints()`](https://dbverse-org.github.io/dbspatial-r/reference/st_npoints.md)
  : Get number of points
- [`st_x()`](https://dbverse-org.github.io/dbspatial-r/reference/st_x.md)
  : Get X coordinate
- [`st_y()`](https://dbverse-org.github.io/dbspatial-r/reference/st_y.md)
  : Get Y coordinate

## Configuration

Global package options.

- [`dbSpatial_options`](https://dbverse-org.github.io/dbspatial-r/reference/dbSpatial_options.md)
  [`dbSpatial-options`](https://dbverse-org.github.io/dbspatial-r/reference/dbSpatial_options.md)
  : dbSpatial Package Global Options
