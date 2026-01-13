#' @include utils.R
NULL

#' Get geometry types (DuckDB-native)
#'
#' @description
#' Returns the geometry type for each row in a [dbSpatial] object using DuckDB's
#' spatial function `ST_GeometryType()`.
#'
#' @param dbSpatial A [dbSpatial] object.
#' @param geomName Geometry column name. Default: `"geom"`.
#' @param ... Additional arguments (ignored).
#'
#' @return A lazy tibble with a single column `geom_type`.
#' @concept geom_scalar
#' @export
st_geometrytype <- function(dbSpatial, geomName = "geom", ...) {
  tbl <- dbSpatial[]
  .check_tbl(tbl = tbl)
  .check_geomName(value = tbl, geomName = geomName)

  if (length(list(...)) > 0) {
    warning("Additional arguments passed via ... are ignored")
  }

  tbl |>
    dplyr::transmute(geom_type = ST_GeometryType(!!rlang::sym(geomName)))
}