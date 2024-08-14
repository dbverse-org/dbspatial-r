#' @keywords internal
.st_geometrytype <- function(dbSpatial, geomName = "geom", ...){
  tbl <- dbSpatial[]
  .check_tbl(tbl = tbl)
  .check_geomName(value = tbl, geomName = geomName)
  
  res <- tbl |>
    dplyr::mutate(!!geomName := st_geometrytype(!!rlang::sym(geomName))) |>
    dplyr::select(!!geomName)
  
  dbSpatial[] <- res
  
  return(dbSpatial)
}

#' @describeIn st_geometrytype Method for `dbSpatial` object
setMethod(
  "st_geometrytype",
  signature(dbSpatial = "dbSpatial"),
  function(dbSpatial, geomName = "geom", ...) 
    .st_geometrytype(dbSpatial, geomName = "geom")
)