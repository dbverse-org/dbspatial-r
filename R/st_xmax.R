#' @keywords internal
.st_xmax <- function(dbSpatial, geomName = "geom", ...) {
  # check inputs
  tbl <- dbSpatial[]
  .check_tbl(tbl = tbl)
  .check_geomName(value = tbl, geomName = geomName)
  
  xmax <- tbl |>
    dplyr::mutate(!!geomName := st_xmax(!!rlang::sym(geomName))) |>
    dplyr::summarize(x = max(!!rlang::sym(geomName), na.rm = TRUE)) |>
    dplyr::pull(x)
  
  return(xmax)
}

#' @describeIn st_xmax Method for `dbSpatial` object
setMethod(
  "st_xmax",
  signature(dbSpatial = "dbSpatial"),
  function(dbSpatial, geomName = "geom", ...) 
    .st_xmax(dbSpatial = dbSpatial, geomName = geomName)
)
