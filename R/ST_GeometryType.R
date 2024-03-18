#' Return geometry type
#'
#' @param tbl name of a table in a duckdb database
#' @param geomName name of the column containing the geometry value in the tbl.
#' default = "geom".
#' @param limit number of rows to return. default = 10.
#'
#' @description 
#' This function returns the geometry type of the specified geometry column in 
#' the specified table.
#' @return tbl_dbi
#' 
#' @export
#' 
#' @keywords geo_properties
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
#' ST_GeometryType(tbl = db_points)
ST_GeometryType <- function(tbl, geomName = "geom", limit = 10){
  # input validation
  con <- dbplyr::remote_con(tbl)
  name <- dbplyr::remote_name(tbl)
  .check_con(conn = con)
  .check_name(name = name)
  .check_geomName(tbl = tbl, geomName = geomName)

  suppressMessages(loadSpatial(conn = con))
  
  sql <- glue::glue("SELECT ST_GeometryType({geomName}) AS geom_type
                     FROM {name} LIMIT {limit}")
  
  DBI::dbGetQuery(con, sql)
  
}