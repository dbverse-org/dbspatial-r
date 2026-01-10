#' @include utils.R
NULL

#' @export
#' @method st_as_text dbSpatial
st_as_text.dbSpatial <- function(x, ...) {
  if (length(list(...)) > 0) warning("Additional arguments passed via ... are ignored")
  .st_mutate_geom(x, "ST_AsText", dest_col = "wkt", args = list())
}

#' @describeIn st_as_geojson Method for `dbSpatial` objects
#' @export
#' @method st_as_geojson dbSpatial
st_as_geojson.dbSpatial <- function(x, ...) {
  if (length(list(...)) > 0) warning("Additional arguments passed via ... are ignored")
  .st_mutate_geom(x, "ST_AsGeoJSON", dest_col = "geojson", args = list())
}
