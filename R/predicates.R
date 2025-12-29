#' @include generics.R st_spatial_join.R
NULL

#' @importFrom sf st_intersects
#' @describeIn st_intersects Method for `dbSpatial` objects
setMethod(
  "st_intersects",
  signature(x = "dbSpatial", y = "dbSpatial"),
  function(x, y, sparse = TRUE, prepared = TRUE, ...) {
    .st_spatial_join(
      g1 = x,
      g2 = y,
      st_name = "ST_Intersects",
      name = "intersect_geom",
      ...
    )
  }
)

#' @importFrom sf st_contains
#' @describeIn st_contains Method for `dbSpatial` objects
setMethod(
  "st_contains",
  signature(x = "dbSpatial", y = "dbSpatial"),
  function(x, y, sparse = TRUE, prepared = TRUE, ...) {
    .st_spatial_join(
      g1 = x,
      g2 = y,
      st_name = "ST_Contains",
      name = "contains_geom",
      ...
    )
  }
)

#' @importFrom sf st_covered_by
#' @describeIn st_covered_by Method for `dbSpatial` objects
setMethod(
  "st_covered_by",
  signature(x = "dbSpatial", y = "dbSpatial"),
  function(x, y, sparse = TRUE, prepared = TRUE, ...) {
    .st_spatial_join(
      g1 = x,
      g2 = y,
      st_name = "ST_CoveredBy",
      name = "covered_by_geom",
      ...
    )
  }
)

#' @importFrom sf st_covers
#' @describeIn st_covers Method for `dbSpatial` objects
setMethod(
  "st_covers",
  signature(x = "dbSpatial", y = "dbSpatial"),
  function(x, y, sparse = TRUE, prepared = TRUE, ...) {
    .st_spatial_join(
      g1 = x,
      g2 = y,
      st_name = "ST_Covers",
      name = "covers_geom",
      ...
    )
  }
)

#' @importFrom sf st_crosses
#' @describeIn st_crosses Method for `dbSpatial` objects
setMethod(
  "st_crosses",
  signature(x = "dbSpatial", y = "dbSpatial"),
  function(x, y, sparse = TRUE, prepared = TRUE, ...) {
    .st_spatial_join(
      g1 = x,
      g2 = y,
      st_name = "ST_Crosses",
      name = "crosses_geom",
      ...
    )
  }
)

#' @importFrom sf st_disjoint
#' @describeIn st_disjoint Method for `dbSpatial` objects
setMethod(
  "st_disjoint",
  signature(x = "dbSpatial", y = "dbSpatial"),
  function(x, y, sparse = TRUE, prepared = TRUE, ...) {
    .st_spatial_join(
      g1 = x,
      g2 = y,
      st_name = "ST_Disjoint",
      name = "disjoint_geom",
      ...
    )
  }
)

#' @importFrom sf st_equals
#' @describeIn st_equals Method for `dbSpatial` objects
setMethod(
  "st_equals",
  signature(x = "dbSpatial", y = "dbSpatial"),
  function(x, y, sparse = TRUE, prepared = TRUE, ...) {
    .st_spatial_join(
      g1 = x,
      g2 = y,
      st_name = "ST_Equals",
      name = "equals_geom",
      ...
    )
  }
)

#' @importFrom sf st_touches
#' @describeIn st_touches Method for `dbSpatial` objects
setMethod(
  "st_touches",
  signature(x = "dbSpatial", y = "dbSpatial"),
  function(x, y, sparse = TRUE, prepared = TRUE, ...) {
    .st_spatial_join(
      g1 = x,
      g2 = y,
      st_name = "ST_Touches",
      name = "touches_geom",
      ...
    )
  }
)

#' @importFrom sf st_within
#' @describeIn st_within Method for `dbSpatial` objects
setMethod(
  "st_within",
  signature(x = "dbSpatial", y = "dbSpatial"),
  function(x, y, sparse = TRUE, prepared = TRUE, ...) {
    .st_spatial_join(
      g1 = x,
      g2 = y,
      st_name = "ST_Within",
      name = "within_geom",
      ...
    )
  }
)

#' @importFrom sf st_overlaps
#' @describeIn st_overlaps Method for `dbSpatial` objects
setMethod(
  "st_overlaps",
  signature(x = "dbSpatial", y = "dbSpatial"),
  function(x, y, sparse = TRUE, prepared = TRUE, ...) {
    .st_spatial_join(
      g1 = x,
      g2 = y,
      st_name = "ST_Overlaps",
      name = "overlaps_geom",
      ...
    )
  }
)

#' @importFrom sf st_is_within_distance
#' @describeIn st_is_within_distance Method for `dbSpatial` objects
setMethod(
  "st_is_within_distance",
  signature(x = "dbSpatial", y = "dbSpatial"),
  function(x, y, dist, sparse = TRUE, ..., remove_self = FALSE) {
    .st_spatial_join(
      g1 = x,
      g2 = y,
      st_name = "ST_DWithin",
      name = "dwithin_geom",
      extra_args = dist,
      ...
    )
  }
)

