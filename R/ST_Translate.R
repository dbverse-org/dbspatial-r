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
#' @keywords geo_construction
#' @examples
#' con = DBI::dbConnect(duckdb::duckdb(), ":memory:")
#' 
#' value = system.file("data", "dummy_points.shp", package = "dbSpatial")
#' 
#' points <- ST_Read(conn = con, name = "points", value = value, overwrite = TRUE)
#' 
#' points |> 
#'   dplyr::mutate(geom_text = ST_AsText(geom))
#' 
#' points_translated <- ST_Translate(tbl = points, dx = 100, dy = -20)
#' 
#' points_translated |> 
#'   dplyr::mutate(geom_text = ST_AsText(geom))
ST_Translate <- function(tbl, geomName = "geom", dx, dy) {
  # check inputs
  .check_tbl(tbl = tbl)
  
  if(missing(dx) | missing(dy)){
    stop("Please provide dx and dy")
  }
  
  if(!is.numeric(dx) | !is.numeric(dy)){
    stop("dx and dy must be numeric")
  }
  
  res <- tbl |>
    dplyr::mutate(!!geomName := ST_Point(ST_X(geom) + dx, ST_Y(geom) + dy))
  
  return(res)
}