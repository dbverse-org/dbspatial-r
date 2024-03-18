#' Determine if geometry is valid
#'
#' @param tbl name of a table in a duckdb database
#' @param limit maximum number of invalid geometries to return
#' @return boolean vector of whether each geometry in tbl is valid
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
#' ST_IsValid(db_points)
ST_IsValid <- function(tbl, limit = 10){
  # check inputs
  con <- dbplyr::remote_con(tbl)
  .check_con(conn = con)
  .check_tbl(tbl = tbl)
  
  if (!is.numeric(limit) || limit < 1) {
    stop("limit must be a positive integer")
  }
  
  suppressMessages(loadSpatial(conn = con))
  
  res <- tbl |>
    dplyr::mutate(is_valid = ST_IsValid(geom)) |>
    dplyr::pull(is_valid) |>
    head(limit)
  
  res
}