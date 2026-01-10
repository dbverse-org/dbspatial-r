#' @include utils.R
NULL

#' @export
#' @method st_area dbSpatial
st_area.dbSpatial <- function(x, ...) {
  if (length(list(...)) > 0) warning("Additional arguments passed via ... are ignored")
  .st_mutate_geom(x, "ST_Area", dest_col = "area", args = list())
}

#' @export
#' @method st_length dbSpatial
st_length.dbSpatial <- function(x, ...) {
  if (length(list(...)) > 0) warning("Additional arguments passed via ... are ignored")
  .st_mutate_geom(x, "ST_Length", dest_col = "length", args = list())
}

#' @export
#' @method st_perimeter dbSpatial
st_perimeter.dbSpatial <- function(x, ...) {
  if (length(list(...)) > 0) warning("Additional arguments passed via ... are ignored")
  .st_mutate_geom(x, "ST_Perimeter", dest_col = "perimeter", args = list())
}
