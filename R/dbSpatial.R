## Constructor ####
#' Create a \code{\link{dbSpatial}} object with geometry
#' @param conn \code{\link{duckdb_connection}}. A connection object to a DuckDB database.
#' @param name \code{character}. Name of table to add to the database.
#' @param value value to be added to database. Can be a data.frame, tbl_duckdb_connection,
#' file path, \code{\link{sf}} object, or \code{\link{terra}} object. 
#' See details for more information.
#' @param x_colName \code{character}. Name of column containing numerical X coordinates. default = NULL.
#' @param y_colName \code{character}. Name of column containing numerical Y coordinates. default = NULL.
#' @param geomName \code{character}. Name of the column containing the geometry. Must start with a character. default = "geom".
#' @param overwrite \code{logical}. Overwrite existing table. default = FALSE.
#' @param ... Additional arguments to be passed
#' 
#' @description
#' Constructor function to ingest a variety of spatial data inputs and create 
#' a \link{dbSpatial} object containing a \code{geometry} data type based
#' on the [Simple Features](https://en.wikipedia.org/wiki/Simple_Features) 
#' standard.
#' 
#' If \code{x_colName} and \code{y_colName} are specified, a point geometry 
#' will be constructed based on these columns.
#'
#' @details
#' For list of files supported see \link{st_read}.
#'
#' TODO: Support for SDF, sf.
#'
#' @return \code{\link{dbSpatial}} object.
#' @export
#'
#' @family constructor
#'
#' @examples
#' # create in-memory DuckDB db
#' duckdb_conn = DBI::dbConnect(duckdb::duckdb(), ":memory:")
#'
#' # test value
#' test_data = data.frame(x = 1:10, y = 1:10, id = 1:10)
#'
#' write.csv(test_data, "test_data.csv", row.names = FALSE)
#'
#' # read data.frame and create point geometry
#' dbSpatial(conn = duckdb_conn,
#'           name = "test_points",
#'           value = test_data,
#'           x_colName = "x",
#'           y_colName = "y",
#'           overwrite = TRUE)
#'
#' # read csv
#' dbSpatial(conn = duckdb_conn,
#'           name = "test_points",
#'           value = 'test_data.csv',
#'           overwrite = TRUE)
dbSpatial <- function(value,
                      name,
                      conn,
                      x_colName = NULL,
                      y_colName = NULL,
                      geomName = "geom",
                      overwrite = FALSE,
                      ...) {
  if(inherits(value, "tbl_duckdb_connection")){
    conn <- dbplyr::remote_con(value)
    name <- dbplyr::remote_name(value)
    overwrite <- 'PASS'
  }
  
  # Input validation
  .check_con(conn)
  .check_name(name)
  .check_value(value)
  .check_overwrite(conn, overwrite, name)
  
  suppressMessages(loadSpatial(conn = conn))
  
  # Handle 'value' inputs
  if (!is.null(x_colName) && !is.null(y_colName)) {
    if(inherits(value, c("SpatVector", "SpatRaster", "sf", "sdf"))){
      stop(paste("Support for point construction only supported for 
                 files, data.frames, data.tables, or tbl_duckdb_connection."))
    }
    if(inherits(value, c("data.frame", "data.table"))){
      DBI::dbWriteTable(
        conn = conn,
        name = name,
        value = value,
        overwrite = overwrite
      )
    } else if (inherits(value, "character")){
      .handle_file(conn, name, value, overwrite)
    }
    .create_pointGeom(conn, name, x_colName, y_colName, geomName)
  } else if (is.character(value)) {
    .handle_file(conn, name, value, overwrite)
  } else if (inherits(value, c("SpatVector", "SpatRaster"))) {
    to_dbSpatial(conn, name, value, overwrite)
  } else if (inherits(value, "tbl_duckdb_connection")){
    .handle_tbl(conn, value)
  } else if (inherits(value, "sf")) {
    to_dbSpatial(conn, name, value, overwrite)
  } else if (inherits(value, "sdf")) {
    stop("Support for 'sdf' objects is not yet implemented.")
  } else {
    stop("Invalid 'value' paramater.")
  }
  
  tbl <- dplyr::tbl(conn, name)
  
  # s3 object construction
  # res <- structure(
  #   list(
  #     value = value,
  #     geometry = "POINT", # Example geometry data as a matrix
  #     conn = conn,
  #     name = name
  #     ),
  #   class = "dbSpatial"
  # )
  
  # S4 object creation
  # res <- new("dbSpatial", 
  #            conn = conn, 
  #            name = name,
  #            geomName = geomName,
  #            value = tbl, 
  #            geometry = "POINT")
  
  return(tbl)
}

## Internal functions ####
#' @description internal func to ingest spatial file
#' @noRd
.handle_file <- function(conn, name, value, overwrite) {
  file_extension <- tools::file_ext(value)
  
  #TODO check geometry type of parquet. usually BLOB, need to convert to WKB
  if(file_extension == "parquet"){
    if(overwrite){
      sql <- glue::glue("CREATE OR REPLACE VIEW {name} AS
                         SELECT * FROM read_parquet('{value}')")
    } else {
      sql <- glue::glue("CREATE VIEW {name} AS
                         SELECT * FROM read_parquet('{value}')")
    }
    DBI::dbSendQuery(conn, sql)
  } else{
    st_read(conn = conn, name = name, value = value, overwrite = overwrite)
  }
}

#' @description internal func to ingest terra object
#' @noRd
.handle_terra <- function(conn, name, value, overwrite) {
  tmp_shp = tempfile(fileext = ".shp")
  

  if(inherits(value, "SpatVector")){
    terra::writeVector(value, 
                       tmp_shp, 
                       filetype = "ESRI Shapefile",
                       overwrite = TRUE)
  } else if(inherits(value, "SpatRaster")){
    terra::writeRaster(value, 
                       tmp_shp, 
                       filetype = "ESRI Shapefile",
                       overwrite = TRUE)
  }
  
  st_read(conn = conn, name = name, value = tmp_shp, overwrite = overwrite)

}

#' @description internal func to ingest tbl_duckdb_connection
#' @noRd
.handle_tbl <- function(conn, value) {
  # empty control logic for now
  return()
}

#' @description internal func to point geometry in table with specified geomName
#' @noRd
.create_pointGeom <- function(conn, name, x_colName, y_colName, geomName) {
  sql <- glue::glue("CREATE OR REPLACE VIEW {name} AS
                     SELECT *, ST_Point({x_colName}, {y_colName}) AS {geomName}
                     FROM {name}")
  
  invisible(DBI::dbExecute(conn, sql))
}
