#' @include generics.R utils.R
NULL

#' @importFrom sf st_area
#' @describeIn st_area Method for `dbSpatial` objects
setMethod(
  "st_area",
  signature(x = "dbSpatial"),
  function(x, ...) {
    if (length(list(...)) > 0) warning("Additional arguments passed via ... are ignored")
    .st_mutate_geom(x, "ST_Area", dest_col = "area", args = list())
  }
)

#' @importFrom sf st_length
#' @describeIn st_length Method for `dbSpatial` objects
setMethod(
  "st_length",
  signature(x = "dbSpatial"),
  function(x, ...) {
    if (length(list(...)) > 0) warning("Additional arguments passed via ... are ignored")
    .st_mutate_geom(x, "ST_Length", dest_col = "length", args = list())
  }
)

#' @importFrom sf st_perimeter
#' @describeIn st_perimeter Method for `dbSpatial` objects
setMethod(
  "st_perimeter",
  signature(x = "dbSpatial"),
  function(x, ...) {
    if (length(list(...)) > 0) warning("Additional arguments passed via ... are ignored")
    .st_mutate_geom(x, "ST_Perimeter", dest_col = "perimeter", args = list())
  }
)
