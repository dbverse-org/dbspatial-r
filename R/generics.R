#' Get maximum x coordinate
#' @name st_xmax
#' @description
#' This function returns the maximum x coordinate in each `geometry` in
#' the specified \code{\link{dbSpatial}} object.
#' @param dbSpatial \code{\link{dbSpatial}} object.
#' @param geomName \code{character string}. The geometry column name in the  \code{\link{dbSpatial}}  object. Default: `"geom"`.
#' @param ... additional arguments passed to methods
#' @return numerical column vector in database
#' @family geom_summary
#' @concept geom_summary
#' @export
#' @examples
#' if (requireNamespace("duckdb", quietly = TRUE)) {
#'   # Create a data.frame with x and y coordinates and attributes
#'   coordinates <- data.frame(x = c(100, 200, 300), y = c(500, 600, 700))
#'   attributes <- data.frame(id = 1:3, name = c("A", "B", "C"))
#'
#'   # Combine the coordinates and attributes
#'   dummy_data <- cbind(coordinates, attributes)
#'
#'   # Create a duckdb connection
#'   con = DBI::dbConnect(duckdb::duckdb(), ":memory:")
#'
#'   # Create a duckdb table with spatial points
#'   db_points = dbSpatial(conn = con,
#'                         value = dummy_data,
#'                         x_colName = "x",
#'                         y_colName = "y",
#'                         name = "foo",
#'                         overwrite = TRUE)
#'
#'   st_xmax(dbSpatial = db_points)
#'   DBI::dbDisconnect(con, shutdown = TRUE)
#' }
setGeneric(
  "st_xmax",
  function(dbSpatial, geomName = "geom", ...) {
    standardGeneric("st_xmax")
  }
)

#' Get maximum y coordinate
#' @name st_ymax
#' @description
#' This function returns the maximum y coordinate of the geometries in the specified \code{\link{dbSpatial}}  object.
#' @param dbSpatial \code{\link{dbSpatial}} object.
#' @param geomName \code{character string}. The geometry column name in the  \code{\link{dbSpatial}}  object. Default: `"geom"`.
#' @param ... additional arguments passed to methods
#' @return numerical column vector in database
#' @family geom_summary
#' @concept geom_summary
#' @export
#' @examples
#' if (requireNamespace("duckdb", quietly = TRUE)) {
#'   # Create a data.frame with x and y coordinates and attributes
#'   coordinates <- data.frame(x = c(100, 200, 300), y = c(500, 600, 700))
#'   attributes <- data.frame(id = 1:3, name = c("A", "B", "C"))
#'
#'   # Combine the coordinates and attributes
#'   dummy_data <- cbind(coordinates, attributes)
#'
#'   # Create a duckdb connection
#'   con = DBI::dbConnect(duckdb::duckdb(), ":memory:")
#'
#'   # Create a duckdb table with spatial points
#'   db_points = dbSpatial(conn = con,
#'                         value = dummy_data,
#'                         x_colName = "x",
#'                         y_colName = "y",
#'                         name = "foo",
#'                         overwrite = TRUE)
#'
#'   st_ymax(dbSpatial = db_points)
#'   DBI::dbDisconnect(con, shutdown = TRUE)
#' }
setGeneric(
  "st_ymax",
  function(dbSpatial, geomName = "geom", ...) {
    standardGeneric("st_ymax")
  }
)

## geom_construction ####
#' Translate x, y coordinates by delta x, delta y for point geometries
#' @name st_translate
#' @description
#' This function translates point geometries by the specified delta x and delta y values.
#' @param dbSpatial \code{\link{dbSpatial}} object.
#' @param geomName \code{character string}. The geometry column name in the  \code{\link{dbSpatial}}  object. Default: `"geom"`.
#' @param dx \code{numeric}.value to shift x coordinates by
#' @param dy \code{numeric}. value to shift y coordinates by
#' @param ... additional arguments passed to methods
#' @return \code{\link{dbSpatial}} object
#' @family geom_construction
#' @concept geom_construction
#' @export
#' @examples
#' if (requireNamespace("duckdb", quietly = TRUE)) {
#'   con = DBI::dbConnect(duckdb::duckdb(), ":memory:")
#'
#'   coordinates <- data.frame(x = c(100, 200, 300), y = c(500, 600, 700))
#'   attributes <- data.frame(id = 1:3, name = c("A", "B", "C"))
#'
#'   # Combine the coordinates and attributes
#'   dummy_data <- cbind(coordinates, attributes)
#'
#'   points <- dbSpatial(conn = con,
#'                       name = "points",
#'                       value = dummy_data,
#'                       overwrite = TRUE,
#'                       x_colName = "x",
#'                       y_colName = "y")
#'
#'   points
#'
#'   points_translated <- st_translate(dbSpatial = points, dx = 100, dy = -20)
#'
#'   points_translated
#'   DBI::dbDisconnect(con, shutdown = TRUE)
#' }
setGeneric(
  "st_translate",
  function(dbSpatial, geomName = "geom", dx, dy, ...) {
    standardGeneric("st_translate")
  }
)


## Measurements ####
#' Get area of geometries
#' @name st_area
#' @description
#' Returns the area of the geometry column.
#' @param x \code{\link{dbSpatial}} object
#' @param geomName \code{character string}. The geometry column name. Default: `"geom"`.
#' @param ... additional arguments passed to methods
#' @return \code{\link{dbSpatial}} object (lazy tibble with area column)
#' @family measurements
#' @concept measurements
#' @importFrom sf st_area

#' @examples
#' \dontrun{
#' st_area(x)
#' }
NULL



#' Get length of geometries
#' @name st_length
#' @description
#' Returns the length of the geometry column.
#' @param x \code{\link{dbSpatial}} object
#' @param geomName \code{character string}. The geometry column name. Default: `"geom"`.
#' @param ... additional arguments passed to methods
#' @return \code{\link{dbSpatial}} object (lazy tibble with length column)
#' @family measurements
#' @concept measurements
#' @importFrom sf st_length

#' @examples
#' \dontrun{
#' st_length(x)
#' }
NULL



#' Get perimeter of geometries
#' @name st_perimeter
#' @description
#' Returns the perimeter of the geometry column.
#' @param x \code{\link{dbSpatial}} object
#' @param geomName \code{character string}. The geometry column name. Default: `"geom"`.
#' @param ... additional arguments passed to methods
#' @return \code{\link{dbSpatial}} object (lazy tibble with perimeter column)
#' @family measurements
#' @concept measurements
#' @importFrom sf st_perimeter

#' @examples
#' \dontrun{
#' st_perimeter(x)
#' }
NULL



## Geometry Operations ####
#' Compute buffer around geometry
#' @name st_buffer
#' @description Returns a geometry that represents all points whose distance from this Geometry is less than or equal to distance.
#' @param x \code{\link{dbSpatial}} object
#' @param dist numeric distance
#' @param ... additional arguments
#' @return \code{\link{dbSpatial}} object with buffered geometry
#' @family geometry_ops
#' @concept geometry_ops
#' @importFrom sf st_buffer

#' @examples
#' \dontrun{
#' st_buffer(x, dist = 1)
#' }
NULL



#' Compute centroid of geometry
#' @name st_centroid
#' @description Returns the geometric center of a geometry.
#' @param x \code{\link{dbSpatial}} object
#' @param ... additional arguments
#' @return \code{\link{dbSpatial}} object with centroid geometry
#' @family geometry_ops
#' @concept geometry_ops
#' @importFrom sf st_centroid

#' @examples
#' \dontrun{
#' st_centroid(x)
#' }
NULL



#' Simplify geometry
#' @name st_simplify
#' @description Returns a simplified version of the given geometry using the Douglas-Peucker algorithm.
#' @param x \code{\link{dbSpatial}} object
#' @param dTolerance numeric tolerance
#' @param ... additional arguments
#' @return \code{\link{dbSpatial}} object with simplified geometry
#' @family geometry_ops
#' @concept geometry_ops
#' @importFrom sf st_simplify

#' @examples
#' \dontrun{
#' st_simplify(x, dTolerance = 0.1)
#' }
NULL



## Accessors ####
#' Get X coordinate
#' @name st_x
#' @description Returns the X coordinate of a point.
#' @param x \code{\link{dbSpatial}} object
#' @param ... additional arguments
#' @return \code{\link{dbSpatial}} object with X coordinate column
#' @family accessors
#' @concept accessors
#' @export
#' @examples
#' \dontrun{
#' st_x(x)
#' }
setGeneric("st_x", function(x, ...) standardGeneric("st_x"))

#' Get Y coordinate
#' @name st_y
#' @description Returns the Y coordinate of a point.
#' @param x \code{\link{dbSpatial}} object
#' @param ... additional arguments
#' @return \code{\link{dbSpatial}} object with Y coordinate column
#' @family accessors
#' @concept accessors
#' @export
#' @examples
#' \dontrun{
#' st_y(x)
#' }
setGeneric("st_y", function(x, ...) standardGeneric("st_y"))

#' Get number of points
#' @name st_npoints
#' @description Returns the number of points in a geometry.
#' @param x \code{\link{dbSpatial}} object
#' @param ... additional arguments
#' @return \code{\link{dbSpatial}} object with npoints column
#' @family accessors
#' @concept accessors
#' @export
#' @examples
#' \dontrun{
#' st_npoints(x)
#' }
setGeneric("st_npoints", function(x, ...) standardGeneric("st_npoints"))

## Constructors ####
#' Convert to WKT
#' @name st_as_text
#' @description Returns the Well-Known Text (WKT) representation of the geometry.
#' @param x \code{\link{dbSpatial}} object
#' @param ... additional arguments
#' @return \code{\link{dbSpatial}} object with WKT column
#' @family constructors
#' @concept constructors
#' @importFrom sf st_as_text

#' @examples
#' \dontrun{
#' st_as_text(x)
#' }
NULL



#' Convert to GeoJSON
#' @name st_as_geojson
#' @description Returns the GeoJSON representation of the geometry.
#' @param x \code{\link{dbSpatial}} object
#' @param ... additional arguments
#' @return \code{\link{dbSpatial}} object with GeoJSON column
#' @family constructors
#' @concept constructors
#' @export
#' @examples
#' \dontrun{
#' st_as_geojson(x)
#' }
setGeneric("st_as_geojson", function(x, ...) standardGeneric("st_as_geojson"))
