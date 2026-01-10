#' @include utils.R
NULL

#' @keywords internal
.st_bbox <- function(dbSpatial, geomName = "geom", ...) {
  tbl <- dbSpatial[]
  .check_tbl(tbl = tbl)
  .check_geomName(value = tbl, geomName = geomName)

  if (length(list(...)) > 0) {
    warning("Additional arguments passed via ... are ignored")
  }

  res <- tbl |>
    dplyr::summarise(
      xmin = min(st_xmin(!!rlang::sym(geomName)), na.rm = TRUE),
      ymin = min(st_ymin(!!rlang::sym(geomName)), na.rm = TRUE),
      xmax = max(st_xmax(!!rlang::sym(geomName)), na.rm = TRUE),
      ymax = max(st_ymax(!!rlang::sym(geomName)), na.rm = TRUE)
    ) |>
    dplyr::collect()

  bb <- c(
    xmin = as.numeric(res$xmin),
    ymin = as.numeric(res$ymin),
    xmax = as.numeric(res$xmax),
    ymax = as.numeric(res$ymax)
  )

  class(bb) <- "bbox"
  attr(bb, "crs") <- sf::NA_crs_

  return(bb)
}

#' Compute bounding box for dbSpatial object
#' @name st_bbox
#' @description
#' Returns the bounding box of the geometry column.
#' @param obj \code{\link{dbSpatial}} object
#' @param ... additional arguments passed to methods
#' @return \code{bbox} object (named numeric vector with xmin, ymin, xmax, ymax)
#' @family geom_summary
#' @concept geom_summary
#' @importFrom sf st_bbox
#' @export
#' @method st_bbox dbSpatial
st_bbox.dbSpatial <- function(obj, ...) {
  .st_bbox(dbSpatial = obj, ...)
}
