#' @include generics.R utils.R
NULL

#' @importFrom sf st_is_valid
#' @describeIn st_is_valid Method for `dbSpatial` objects
setMethod(
  "st_is_valid",
  signature(x = "dbSpatial"),
  function(x, ...) {
    if (length(list(...)) > 0) {
      warning("Additional arguments passed via ... are ignored")
    }

    .st_mutate_geom(x, "ST_IsValid", args = list())
  }
)
