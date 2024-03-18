#' Get maximum y coordinate
#'
#' @param tbl name of a table in a duckdb database
#' @param geomName name of the column containing the geometry value in the tbl
#' default = "geom".
#'
#' @return maximum y coordinate
#' @export
#' @keywords spatial_prop
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
#' ST_YMax(tbl = db_points)
ST_YMax <- function(tbl, geomName = "geom") {
  # check inputs
  con <- dbplyr::remote_con(tbl)
  .check_con(conn = con)
  .check_tbl(tbl = tbl)
  .check_geomName(tbl = tbl, geomName = geomName)
  
  suppressMessages(loadSpatial(conn = con))
  
  res <- tbl |>
    dplyr::mutate(x = ST_Y(geom)) |>
    dplyr::pull(x) |>
    max()
  
  res
}