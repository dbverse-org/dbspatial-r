#' @include st_spatial_join.R
NULL

#' @export
#' @method st_intersects dbSpatial
st_intersects.dbSpatial <- function(x, y, sparse = TRUE, prepared = TRUE, ...) {
  .st_spatial_join(
    g1 = x,
    g2 = y,
    st_name = "ST_Intersects",
    name = "intersect_geom",
    ...
  )
}

#' @export
#' @method st_contains dbSpatial
st_contains.dbSpatial <- function(x, y, sparse = TRUE, prepared = TRUE, ...) {
  .st_spatial_join(
    g1 = x,
    g2 = y,
    st_name = "ST_Contains",
    name = "contains_geom",
    ...
  )
}

#' @export
#' @method st_covered_by dbSpatial
st_covered_by.dbSpatial <- function(x, y, sparse = TRUE, prepared = TRUE, ...) {
  .st_spatial_join(
    g1 = x,
    g2 = y,
    st_name = "ST_CoveredBy",
    name = "covered_by_geom",
    ...
  )
}

#' @export
#' @method st_covers dbSpatial
st_covers.dbSpatial <- function(x, y, sparse = TRUE, prepared = TRUE, ...) {
  .st_spatial_join(
    g1 = x,
    g2 = y,
    st_name = "ST_Covers",
    name = "covers_geom",
    ...
  )
}

#' @export
#' @method st_crosses dbSpatial
st_crosses.dbSpatial <- function(x, y, sparse = TRUE, prepared = TRUE, ...) {
  .st_spatial_join(
    g1 = x,
    g2 = y,
    st_name = "ST_Crosses",
    name = "crosses_geom",
    ...
  )
}

#' @export
#' @method st_disjoint dbSpatial
st_disjoint.dbSpatial <- function(x, y, sparse = TRUE, prepared = TRUE, ...) {
  .st_spatial_join(
    g1 = x,
    g2 = y,
    st_name = "ST_Disjoint",
    name = "disjoint_geom",
    ...
  )
}

#' @export
#' @method st_equals dbSpatial
st_equals.dbSpatial <- function(x, y, sparse = TRUE, prepared = TRUE, ...) {
  .st_spatial_join(
    g1 = x,
    g2 = y,
    st_name = "ST_Equals",
    name = "equals_geom",
    ...
  )
}

#' @export
#' @method st_touches dbSpatial
st_touches.dbSpatial <- function(x, y, sparse = TRUE, prepared = TRUE, ...) {
  .st_spatial_join(
    g1 = x,
    g2 = y,
    st_name = "ST_Touches",
    name = "touches_geom",
    ...
  )
}

#' @export
#' @method st_within dbSpatial
st_within.dbSpatial <- function(x, y, sparse = TRUE, prepared = TRUE, ...) {
  .st_spatial_join(
    g1 = x,
    g2 = y,
    st_name = "ST_Within",
    name = "within_geom",
    ...
  )
}

#' @export
#' @method st_overlaps dbSpatial
st_overlaps.dbSpatial <- function(x, y, sparse = TRUE, prepared = TRUE, ...) {
  .st_spatial_join(
    g1 = x,
    g2 = y,
    st_name = "ST_Overlaps",
    name = "overlaps_geom",
    ...
  )
}

#' @export
#' @method st_is_within_distance dbSpatial
st_is_within_distance.dbSpatial <- function(x, y, dist, sparse = TRUE, ..., remove_self = FALSE) {
  .st_spatial_join(
    g1 = x,
    g2 = y,
    st_name = "ST_DWithin",
    name = "dwithin_geom",
    extra_args = dist,
    ...
  )
}
