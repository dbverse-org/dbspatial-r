#' @include generics.R utils.R
NULL

#' @importFrom sf st_as_text
#' @describeIn st_as_text Method for `dbSpatial` objects
setMethod(
  "st_as_text",
  signature(x = "dbSpatial"),
  function(x, ...) {
    if (length(list(...)) > 0) warning("Additional arguments passed via ... are ignored")
    .st_mutate_geom(x, "ST_AsText", dest_col = "wkt", args = list())
  }
)

#' @describeIn st_as_geojson Method for `dbSpatial` objects
setMethod(
  "st_as_geojson",
  signature(x = "dbSpatial"),
  function(x, ...) {
    if (length(list(...)) > 0) warning("Additional arguments passed via ... are ignored")
    .st_mutate_geom(x, "ST_AsGeoJSON", dest_col = "geojson", args = list())
  }
)
