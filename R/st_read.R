#' Ingest spatial data from a file as a `VIEW` and create a `dbSpatial` object
#' @param conn a duckdb connection
#' @param name name of the table to be created
#' @param value a data.frame or a file path
#' @param x_colName name of the column containing x coordinates. default: 'NULL'
#' @param y_colName name of the column containing y coordinates. default: 'NULL'
#' @param geomName name of the geometry column to be created. default: 'geom'
#' @param overwrite logical; if TRUE, overwrite the table if it already exists
#' default: 'FALSE'
#' @param return return dbSpatial object. default: 'FALSE'
#' @param ... additional arguments to pass to st_read
#' @details
#' For list of files supported see the documentation below.
#' <https://DuckDB.org/docs/extensions/spatial.html#st_read---read-spatial-value-from-files>
#' @return `dbSpatial` object if `return = TRUE` else `NULL`
#' @keywords internal
.st_read <- function(conn,
                     name,
                     value,
                     x_colName = NULL,
                     y_colName = NULL,
                     geomName = "geom",
                     overwrite = FALSE,
                     return = TRUE,
                     ...) {
  # input validation
  .check_con(conn)
  .check_name(name)
  .check_value(value)
  .check_overwrite(conn, overwrite, name)
  
  suppressMessages(loadSpatial(conn = conn))
  
  file_extension <- tools::file_ext(value)
  
  # Determine if we should use OR REPLACE
  replace_check <- if (overwrite) "OR REPLACE" else ""
  
  # Determine which read function to use based on file extension
  file_extension <- tools::file_ext(value)
  read_function <- if (tolower(file_extension) == "parquet") "read_parquet" else "ST_Read"
  
  # Add ST_Point column if x_colName and y_colName are provided
  point_column <- if (!is.null(x_colName) && !is.null(y_colName)) {
    #.check_geomName(value = value, geomName = geomName)
    glue::glue(", ST_Point(CAST({x_colName} AS DOUBLE), 
               CAST({y_colName} AS DOUBLE)) AS {geomName}")
  } else {
    ""
  }
  
  sql <- glue::glue("
  CREATE {replace_check} VIEW {name} AS
  SELECT *{point_column}
  FROM {read_function}('{value}')
  ")
  
  # Execute the SQL command
  DBI::dbExecute(conn, sql)
  
  if (return) {
    out_tbl <- dplyr::tbl(conn, name)
    
    res <- dbSpatial(
      conn = conn,
      name = name,
      value = out_tbl
    )
    
    return(res) 
  }
  return()
}