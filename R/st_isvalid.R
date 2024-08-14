#' @keywords internal
.st_isvalid <- function(dbSpatial, geomName = "geom", ...){
  # check inputs
  tbl <- dbSpatial[]
  .check_tbl(tbl = tbl)
  .check_geomName(value = tbl, geomName = geomName)
  
  res <- tbl |>
    dplyr::mutate(!!geomName := st_isvalid(!!rlang::sym(geomName))) |>
    dplyr::select(!!geomName)
  
  dbSpatial[] <- res
  
  return(dbSpatial)
}

#' @describeIn st_isvalid Method for `dbSpatial` object
setMethod(
  "st_isvalid",
  signature(dbSpatial = "dbSpatial"),
  function(dbSpatial, geomName = "geom", ...) 
    .st_isvalid(dbSpatial = dbSpatial, geomName = "geom")
)

