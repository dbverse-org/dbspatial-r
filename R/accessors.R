#' @include classes.R generics.R utils.R
NULL

#' @describeIn st_x Method for `dbSpatial` objects
setMethod(
  "st_x",
  signature(x = "dbSpatial"),
  function(x, ...) {
    .st_mutate_geom(x, "ST_X", dest_col = "x", args = list(...))
  }
)

#' @describeIn st_y Method for `dbSpatial` objects
setMethod(
  "st_y",
  signature(x = "dbSpatial"),
  function(x, ...) {
    .st_mutate_geom(x, "ST_Y", dest_col = "y", args = list(...))
  }
)

#' @describeIn st_npoints Method for `dbSpatial` objects
setMethod(
  "st_npoints",
  signature(x = "dbSpatial"),
  function(x, ...) {
    .st_mutate_geom(x, "ST_NPoints", dest_col = "npoints", args = list(...))
  }
)
