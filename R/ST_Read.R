#' Read spatial data from a file and create a table in a duckdb database
#'
#' @param conn a duckdb connection
#' @param name name of the table to be created
#' @param value a data.frame or a file path
#' @param overwrite logical; if TRUE, overwrite the table if it already exists
#' @param ... additional arguments to pass to ST_Read
#'
#' @details
#' For list of files supported see the documentation below.
#' <https://DuckDB.org/docs/extensions/spatial.html#st_read---read-spatial-value-from-files>
#'
#' @return tbl_dbi
#' 
#' @export
#' 
#' @keywords geo_construction
#' @examples
#' con = DBI::dbConnect(duckdb::duckdb(), ":memory:")
#' 
#' value = system.file("data", "dummy_points.shp", package = "dbSpatial")
#' 
#' points <- ST_Read(conn = con, name = "points", value = value, overwrite = TRUE)
#' 
#' points
ST_Read <- function(conn, name, value, overwrite = FALSE, ...){
  # input validation
  .check_con(conn)
  .check_name(name)
  .check_value(value)
  .check_overwrite(conn, overwrite, name)
  
  suppressMessages(loadSpatial(conn = conn))
  
  if(overwrite){
    sql <- glue::glue("CREATE OR REPLACE TABLE {name} AS
                SELECT * FROM ST_Read('{value}')")
  } else{
    sql <- glue::glue("CREATE TABLE {name} AS
                SELECT * FROM ST_Read('{value}')")
  }

  DBI::dbExecute(conn, sql)
  
  res <- dplyr::tbl(conn, name)
  
  return(res)
}