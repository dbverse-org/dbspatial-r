#' @keywords internal
.st_extent <- function(dbSpatial, geomName = "geom", ...) {
  tbl <- dbSpatial[]
  con <- dbplyr::remote_con(tbl)
  .check_con(conn = con)
  .check_tbl(tbl = tbl)
  .check_geomName(value = tbl, geomName = geomName)
  
  res <- tbl |>
    dplyr::summarise(
      xmin = min(st_xmin(geom)),
      xmax = max(st_xmax(geom)),
      ymin = min(st_ymin(geom)),
      ymax = max(st_ymax(geom))
    ) |>
    dplyr::collect() |>
    unlist() # conversion to named numeric vector
  
  return(res)
}

#' @describeIn st_extent Method for `dbSpatial` objects
setMethod(
  "st_extent",
  signature(dbSpatial = "dbSpatial"),
  function(dbSpatial, geomName = "geom", ...)
    .st_extent(dbSpatial, geomName = "geom")
)