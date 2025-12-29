#' @include generics.R utils.R
NULL

#' @importFrom sf st_geometry_type
#' @describeIn st_geometry_type Method for `dbSpatial` objects
setMethod(
  "st_geometry_type",
  signature(x = "dbSpatial"),
  function(x, by_geometry = TRUE) {
    if (!by_geometry) {
      warning("by_geometry = FALSE is ignored; returning row-wise geometry types")
    }

    .st_mutate_geom(x, "ST_GeometryType", args = list())
  }
)
