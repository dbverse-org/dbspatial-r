#' Get extent of a geometry
#'
#' @param tbl name of a table in a duckdb database containing geometry column
#' @param geomName name of the column containing the geometry value in the tbl
#'
#' @return data.frame of extent of geom column in tbl
#' @export
#' @keywords geom_summary
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
#' # Get extent of the table
#' st_extent(db_points)
st_extent <- function(tbl, geomName = "geom"){
  con <- dbplyr::remote_con(tbl)
  name <- dbplyr::remote_name(tbl)
  .check_con(conn = con)
  .check_name(name = name)
  .check_tbl(tbl = tbl)
  .check_geomName(tbl = tbl, geomName = geomName)
  
  suppressMessages(loadSpatial(conn = con))
  
  res <- tbl |>
    dplyr::mutate(extent = ST_Extent(geom)) |>
    dplyr::pull(extent) |>
    dplyr::summarize(
      min_x = min(min_x),
      max_x = max(max_x),
      min_y = min(min_y),
      max_y = max(max_y)
    )
  
  res
}