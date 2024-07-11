#' Read spatial data from a file and create a table in a duckdb database
#'
#' @param conn a duckdb connection
#' @param name name of the table to be created
#' @param value a data.frame or a file path
#' @param overwrite logical; if TRUE, overwrite the table if it already exists
#' @param ... additional arguments to pass to st_read
#'
#' @details
#' For list of files supported see the documentation below.
#' <https://DuckDB.org/docs/extensions/spatial.html#st_read---read-spatial-value-from-files>
#'
#' @return tbl_dbi
#' 
#' @export
#' 
#' @family geom_construction
#' @examples
#' con = DBI::dbConnect(duckdb::duckdb(), ":memory:")
#' 
#' coordinates <- data.frame(x = c(100, 200, 300), y = c(500, 600, 700))
#' attributes <- data.frame(id = 1:3, name = c("A", "B", "C"))
#'
#' # Combine the coordinates and attributes
#' dummy_data <- cbind(coordinates, attributes)
#' 
#' write.csv(dummy_data, "dummy_data.csv", row.names = FALSE)
#'  
#' data <- st_read(conn = con, 
#'                 name = "points", 
#'                 value = "dummy_data.csv", 
#'                 overwrite = TRUE)
#' 
#' data
st_read <- function(conn, name, value, overwrite = FALSE, ...){
  # input validation
  .check_con(conn)
  .check_name(name)
  .check_value(value)
  .check_overwrite(conn, overwrite, name)
  
  suppressMessages(loadSpatial(conn = conn))
  
  if(overwrite){
    sql <- glue::glue("CREATE OR REPLACE VIEW {name} AS
                       SELECT * FROM ST_Read('{value}')")
  } else{
    sql <- glue::glue("CREATE VIEW {name} AS
                       SELECT * FROM ST_Read('{value}')")
  }

  DBI::dbExecute(conn, sql)
  
  res <- dplyr::tbl(conn, name)
  
  return(res)
}