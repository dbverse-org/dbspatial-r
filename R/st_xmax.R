#' Get maximum x coordinate
#'
#' @param tbl name of a table in a duckdb database
#' @param geomName name of the column containing the geometry value in the tbl
#' default = "geom".
#' 
#' @description 
#' This function returns the maximum x coordinate in each `geometry` in 
#' the specified \code{\link{dbSpatial}} object.
#'  
#' @return numerical vector in database
#' @export
#' @family geom_solo
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
#' st_xmax(tbl = db_points)
st_xmax <- function(tbl, geomName = "geom") {
  # check inputs
  .check_tbl(tbl = tbl)
  .check_geomName(tbl = tbl, geomName = geomName)
  
  res <- tbl |>
    dplyr::mutate(!!geomName := st_xmax(rlang::sym(!!geomName))) |>
    dplyr::select(!!geomName)
  
  return(res)
}