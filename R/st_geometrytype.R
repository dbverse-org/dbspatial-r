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
#' @param collect Logical (default = `FALSE`). If `TRUE`, collect results into
#' a character vector.
#' @param n Optional integer. If provided alongside `collect = TRUE`, limits the
#' query to the first `n` rows before collecting.
#' @param ... Additional arguments (ignored).
#'
#' @return If `collect = FALSE` (default), a lazy tibble with a single column
#' `geom_type`. If `collect = TRUE`, a character vector of geometry type(s).
#' @concept geom_scalar
#' @export
st_geometrytype <- function(dbSpatial, geomName = "geom", collect = FALSE, n = NULL, ...) {
  tbl <- dbSpatial[]
  .check_tbl(tbl = tbl)
  .check_geomName(value = tbl, geomName = geomName)

  if (length(list(...)) > 0) {
    warning("Additional arguments passed via ... are ignored")
  }

  gt_tbl <- tbl |>
    dplyr::transmute(geom_type = ST_GeometryType(!!rlang::sym(geomName)))

  if (!isTRUE(collect)) {
    return(gt_tbl)
  }

  if (!is.null(n)) {
    checkmate::assert_int(n, lower = 1)
    gt_tbl <- head(gt_tbl, n = n)
  }

  gt_tbl |>
    dplyr::collect() |>
    dplyr::pull(geom_type) |>
    as.character()
}