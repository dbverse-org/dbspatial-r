#' @include utils.R
NULL

#' @export
#' @method st_geometry_type dbSpatial
st_geometry_type.dbSpatial <- function(x, by_geometry = TRUE, ...) {
  if (!by_geometry) {
    warning("by_geometry = FALSE is ignored; returning row-wise geometry types")
  }

  .st_mutate_geom(x, "ST_GeometryType", args = list())
}
