#' @include utils.R
NULL

#' @export
#' @method st_buffer dbSpatial
st_buffer.dbSpatial <- function(
    x,
    dist,
    nQuadSegs = 30,
    endCapStyle = "ROUND",
    joinStyle = "ROUND",
    mitreLimit = 1,
    singleSide = FALSE,
    ...
) {
  if (endCapStyle != "ROUND") {
    warning("endCapStyle argument is ignored (DuckDB ST_Buffer uses ROUND)")
  }
  if (joinStyle != "ROUND") {
    warning("joinStyle argument is ignored (DuckDB ST_Buffer uses ROUND)")
  }
  if (mitreLimit != 1) {
    warning("mitreLimit argument is ignored")
  }
  if (singleSide) {
    warning("singleSide argument is ignored")
  }
  if (length(list(...)) > 0) {
    warning("Additional arguments passed via ... are ignored")
  }

  .st_mutate_geom(
    x,
    "ST_Buffer",
    args = list(dist = dist, nQuadSegs = as.integer(nQuadSegs)),
    param_names = c("dist", "nQuadSegs")
  )
}

#' @export
#' @method st_centroid dbSpatial
st_centroid.dbSpatial <- function(x, ..., of_largest_polygon = FALSE) {
  if (of_largest_polygon) {
    warning(
      "of_largest_polygon argument is ignored (not supported by DuckDB ST_Centroid)"
    )
  }
  if (length(list(...)) > 0) {
    warning("Additional arguments passed via ... are ignored")
  }

  .st_mutate_geom(x, "ST_Centroid", args = list())
}

#' @export
#' @method st_simplify dbSpatial
st_simplify.dbSpatial <- function(x, preserveTopology = FALSE, dTolerance = 0, ...) {
  if (isTRUE(preserveTopology)) {
    warning(
      "preserveTopology = TRUE is ignored (DuckDB ST_Simplify does not preserve topology)"
    )
  }

  .st_mutate_geom(
    x,
    "ST_Simplify",
    args = list(tolerance = dTolerance),
    param_names = c("tolerance")
  )
}
