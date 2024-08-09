#' @keywords internal
.st_translate <- function(dbSpatial, geomName = "geom", dx, dy, ...) {
  # check inputs
  tbl <- dbSpatial[]
  .check_tbl(tbl = tbl)
  .check_geomName(value = tbl, geomName = geomName)
  
  if(missing(dx) | missing(dy)){
    stop("Please provide dx and dy")
  }
  
  if(!is.numeric(dx) | !is.numeric(dy)){
    stop("dx and dy must be numeric")
  }
  
  # check to see what geometry type, if polygon then stop
  geomType <- st_geometrytype(dbSpatial = dbSpatial, geomName = geomName)[] |>
    head(1) |>
    dplyr::pull()
  
  if(geomType != "POINT"){
    stop("Only POINT geometry is currently supported for st_translate.")
  }
  
  # TODO: native translate, no casting
  res <- tbl |>
    dplyr::mutate(!!geomName := st_point(st_x(!!rlang::sym(geomName)) + dx, 
                                         st_y(!!rlang::sym(geomName)) + dy))

  dbSpatial[] <- res
  
  return(dbSpatial)
}

#' @describeIn st_translate Method for `dbSpatial` object
setMethod(
  "st_translate",
  signature(dbSpatial = "dbSpatial"),
  function(dbSpatial, geomName = "geom", dx, dy, ...) 
    .st_translate(dbSpatial = dbSpatial, geomName = geomName, dx = dx, dy = dy)
)
