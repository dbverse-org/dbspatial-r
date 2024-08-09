#' @describeIn st_coveredby Method for `dbSpatial` objects
setMethod(
  "st_coveredby",
  signature(g1 = "dbSpatial", g2 = "dbSpatial"),
  function(g1,
           g1_geomName = "geom",
           g1_cols_keep = "all",
           g2,
           g2_geomName = "geom",
           g2_cols_keep = "all",
           overwrite = FALSE,
           name = "coveredBy_geom",
           ...) {
    .st_spatial_relationship(
      g1,
      g1_geomName,
      g1_cols_keep,
      g2,
      g2_geomName,
      g2_cols_keep,
      overwrite,
      name,
      "st_coveredby",
      ...
    )
  }
)