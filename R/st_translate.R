#' Translate x, y coordinates by delta x, delta y
#'
#' @param tbl name of a table in a duckdb database
#' @param geomName name of the column containing the geometry value in the tbl.
#' default = "geom".
#' @param dx delta x
#' @param dy delta y
#'
#' @return a duckdb table with translated geometries
#' @export
#' @keywords geom_mod
#' @examples
#' con = DBI::dbConnect(duckdb::duckdb(), ":memory:")
#' 
#' coordinates <- data.frame(x = c(100, 200, 300), y = c(500, 600, 700))
#' attributes <- data.frame(id = 1:3, name = c("A", "B", "C"))
#'
#' # Combine the coordinates and attributes
#' dummy_data <- cbind(coordinates, attributes)
#'  
#' points <- dbSpatial(conn = con,
#'                     name = "points", 
#'                     value = dummy_data, 
#'                     overwrite = TRUE, 
#'                     x_colName = "x", 
#'                     y_colName = "y")
#' 
#' points |>
#'  dplyr::mutate(geom_text = ST_AsText(geom))
#' 
#' points_translated <- st_translate(tbl = points, dx = 100, dy = -20)
#' 
#' points_translated |>
#'   dplyr::mutate(geom_text = ST_AsText(geom))
st_translate <- function(tbl, geomName = "geom", dx, dy) {
  # check inputs
  .check_tbl(tbl = tbl)
  .check_geomName(tbl = tbl, geomName = geomName)
  
  if(missing(dx) | missing(dy)){
    stop("Please provide dx and dy")
  }
  
  if(!is.numeric(dx) | !is.numeric(dy)){
    stop("dx and dy must be numeric")
  }
  
  # check to see what geometry type, if polygon then stop
  if(st_geometrytype(tbl = tbl, geomName = geomName) != "POINT"){
    stop("Only POINT geometry is  currently supported for st_translate.")
  }
  
  # TODO: native translate, no casting
  res <- tbl |>
    dplyr::mutate(!!geomName := st_point(st_x(geom) + dx, st_y(geom) + dy))
  
  return(res)
}