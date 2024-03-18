#' Create a \code{dbSpatial} object with geometry value.
#' @param conn Connection to \link{DuckDB} database. \link{duckdb_connection}.
#' @param name Name of table to set in the database. Character.
#' @param value value to be added to database. Can be a data.frame, tbl,
#' file path, or \link{terra} object. See details for more information.
#' @param x_colName Name of column containing X coordinates. Numeric.
#' @param y_colName Name of column containing Y coordinates. Numeric.
#' @param overwrite Overwrite existing table (default = FALSE).
#' @param ... Additional arguments to be passed
#' 
#' @description
#' This function reads in a variety of input value types containing spatial value
#' and creates a \link{dbSpatial} object which contains a \code{geometry} value type.
#' If \code{x_colName} and \code{y_colName} are specified, a point geometry will be constructed.
#'
#' @details
#' For list of files supported see \link{ST_Read}.
#'
#' TODO: Support for an existing 'geom' column in DT or DF. e.g. SDF, sf, terra.
#'
#' @return A \code{dbSpatial} object with geometry value.
#' @export
#'
#' @keywords constructor
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
dbSpatial <- function(conn,
                      name,
                      value,
                      x_colName,
                      y_colName,
                      overwrite = FALSE,
                      ...) {
  # Input validation
  .check_con(conn)
  .check_name(name)
  .check_value(value)
  .check_overwrite(conn, overwrite, name)
  
  if(!missing(x_colName) & !missing(y_colName)) {
    if(!is.character(x_colName) | !is.character(y_colName)) {
      stop("x_colName and y_colName must be character strings")
    }
    
    if(!x_colName %in% names(value) | !y_colName %in% names(value)) {
      stop("x_colName and y_colName must be columns in value")
    }
  }
  
  suppressMessages(loadSpatial(conn = conn))
  
  # Ingest value into DB
  if(inherits(value, "data.frame")) { # write to db
    # TODO: how do in-memory geometry columns get written to DuckDB? see sdf
    DBI::dbWriteTable(conn, name, value)
  } else if(is.character(value)) { # read spatial file
    
    file_extension <- tools::file_ext(value)
    
    if(file_extension == "parquet"){
      if(overwrite){
        sql <- glue::glue("CREATE OR REPLACE TABLE {name} AS
                           SELECT * FROM read_parquet('{value}');")
      } else {
        sql <- glue::glue("CREATE TABLE {name} AS
                           SELECT * FROM read_parquet('{value}')")
      }
      DBI::dbSendQuery(con, sql)
    } else{
      ST_Read(conn = conn,
              name = name,
              value = value,
              overwrite = overwrite)
    }
    
  } else if(inherits(value, "SpatVector") | inherits(value, "SpatRaster")){
    # TODO: implement geoarrow integration
    tmp_shp = tempfile(fileext = ".shp")
    if (inherits(value, "SpatRaster")) {
      terra::writeRaster(value, tmp_shp, filetype = "ESRI Shapefile", overwrite = TRUE)
    } else if (inherits(value, "SpatVector")) {
      terra::writeVector(value, tmp_shp, filetype = "ESRI Shapefile", overwrite = TRUE)
    }
    
    # load value into DuckDB
    ST_Read(conn, name, tmp_shp)
    
  } else{
    stop("Invalid value.")
  }
  
  # create point geometry if x_colName and y_colName are specified
  if(!missing(x_colName) & !missing(y_colName)) {
    sql <- glue::glue("CREATE OR REPLACE TABLE {name} AS
                       SELECT *, ST_Point({x_colName}, {y_colName}) AS geom
                       FROM {name};")
    invisible(DBI::dbExecute(conn, sql))
  }
  
  res <- dplyr::tbl(conn, name)
  
  # res <- structure(
  #   list(
  #     value = value,
  #     geometry = "POINT", # Example geometry data as a matrix
  #     conn = conn,
  #     name = name
  #     ),
  #   class = "dbSpatial"
  # )
  
  return(res)
}


