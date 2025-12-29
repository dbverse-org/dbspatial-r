#' @include generics.R utils.R
NULL

#' @importFrom sf st_buffer
#' @describeIn st_buffer Method for `dbSpatial` objects
setMethod(
  "st_buffer",
  signature(x = "dbSpatial"),
  function(
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
)

#' @importFrom sf st_centroid
#' @describeIn st_centroid Method for `dbSpatial` objects
setMethod(
  "st_centroid",
  signature(x = "dbSpatial"),
  function(x, ..., of_largest_polygon = FALSE) {
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
)

#' @importFrom sf st_simplify
#' @describeIn st_simplify Method for `dbSpatial` objects
setMethod(
  "st_simplify",
  signature(x = "dbSpatial"),
  function(x, preserveTopology, dTolerance = 0) {
    if (!missing(preserveTopology) && isTRUE(preserveTopology)) {
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
)
