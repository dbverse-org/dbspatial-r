#' Return geometry type
#'
#' @param tbl name of a table in a duckdb database
#' @param geomName name of the column containing the geometry value in the tbl.
#' default = "geom".
#'
#' @description 
#' This function returns the geometry type of the specified geometry column in 
#' the specified table.
#' @return character vector in database
#' 
#' @export
#' 
#' @keywords geom_solo
#' @examples
#' # Create a data.frame with x and y coordinates and attributes
#' coordinates <- data.frame(x = c(100, 200, 300), y = c(500, 600, 700))
#' attributes <- data.frame(id = 1:3, name = c("A", "B", "C"))
#'
#' # Combine the coordinates and attributes
#' dummy_data <- cbind(coordinates, attributes)
#' 
#' # Create a duckdb connection
#' con = DBI::dbConnect(duckdb::duckdb(), ":memory:")
#'
#' # Create a duckdb table with spatial points
#' db_points = dbSpatial(conn = con,
#'                       value = dummy_data,
#'                       x_colName = "x",
#'                       y_colName = "y",
#'                       name = "foo",
#'                       overwrite = TRUE)
#'                       
#' st_geometrytype(tbl = db_points)
st_geometrytype <- function(tbl, geomName = "geom"){
  # input validation
  .check_tbl(tbl = tbl)
  .check_geomName(tbl = tbl, geomName = geomName)
  
  res <- tbl |>
    dplyr::mutate(!!geomName := st_geometrytype(rlang::sym(!!geomName))) |>
    dplyr::select(!!geomName)
  
  return(res)
}