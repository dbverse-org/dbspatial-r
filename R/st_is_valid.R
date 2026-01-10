#' @include utils.R
NULL

#' @export
#' @method st_is_valid dbSpatial
st_is_valid.dbSpatial <- function(x, ...) {
  if (length(list(...)) > 0) {
    warning("Additional arguments passed via ... are ignored")
  }

  .st_mutate_geom(x, "ST_IsValid", args = list())
}
