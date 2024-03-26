#' Determine if geometry is valid
#'
#' @param tbl name of a table in a duckdb database
#' @param geomName name of the column containing the geometry value in the tbl.
#' default = "geom".
#' 
#' @description 
#' This function returns whether the specified geometry column in the specified
#' table is valid or not. 
#' @return boolean vector in database
#' 
#' @export
#' @keywords geom_solo
#' @examples
#' # Create a data.frame with x and y coordinates and attributes
#' coordinates <- data.frame(x = c(100, 200, 300), y = c(500, 600, 700))
#' attributes <- data.frame(id = 1:3, name = c("A", "B", "C"))
#'
#' # Combine the coordinates and attributes
#' dummy_data <- cbind(coordinates, attributes)
#'
#' # Create a SpatVector from the data.frame
#' dummy_spatvector <- terra::vect(dummy_data, geom = c("x", "y"))
#'
#' # Create a duckdb connection
#' duckdb_conn = DBI::dbConnect(duckdb::duckdb(), ":memory:")
#'
#' # Create a duckdb table with spatial points
#' db_points = dbSpatial(conn = duckdb_conn,
#'                       name = "spatVector_proxy",
#'                       value = dummy_spatvector,
#'                       overwrite = TRUE)
#'                       
#' # Get extent of the table
#' st_isvalid(db_points)
st_isvalid <- function(tbl, geomName = "geom"){
  # check inputs
  .check_tbl(tbl = tbl)
  .check_geomName(tbl = tbl, geomName = geomName)
  
  res <- tbl |>
    dplyr::mutate(!!geomName := st_isvalid(rlang::sym(!!geomName))) |>
    dplyr::select(!!geomName)
  
  return(res)
}