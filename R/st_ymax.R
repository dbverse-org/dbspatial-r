#' @keywords internal
.st_ymax <- function(dbSpatial, geomName = "geom", ...) {
  # check inputs
  tbl <- dbSpatial[]
  .check_tbl(tbl = tbl)
  .check_geomName(value = tbl, geomName = geomName)
  
  ymax <- tbl |>
    dplyr::mutate(!!geomName := st_ymax(!!rlang::sym(geomName))) |>
    dplyr::summarize(y = max(!!rlang::sym(geomName), na.rm = TRUE)) |>
    dplyr::pull(y)
  
  return(ymax)
}

#' @describeIn st_ymax Method for `dbSpatial` object
setMethod(
  "st_ymax",
  signature(dbSpatial = "dbSpatial"),
  function(dbSpatial, geomName = "geom", ...) 
    .st_ymax(dbSpatial = dbSpatial, geomName = geomName)
)
