## Constructor ####
#' Create a \code{\link{dbSpatial}} object with geometry data type
#' @inheritParams DBI::dbWriteTable
#' @param value \code{\link{data.frame}}, `tbl_duckdb_connection`,
#' \code{character} (valid file path), \code{\link{sf}} object, or \code{\link{terra}} object. 
#' Data to construct \code{\link{dbSpatial}} object with geometry data type.
#' See details for more information.
#' @param x_colName \code{character}. Name of column containing numerical X coordinates. default = `NULL`.
#' @param y_colName \code{character}. Name of column containing numerical Y coordinates. default = `NULL`.
#' @param geomName \code{character string}. The geometry column name in the  \code{\link{dbSpatial}}  object. Default: `"geom"`.
#' @param overwrite \code{logical}. Overwrite existing table. default = `FALSE`.
#' @param ... Additional arguments to be passed
#' 
#' @description
#' Constructor function to ingest diverse spatial data sources and create 
#' a \code{\link{dbSpatial}} object containing a \code{geometry} data type based
#' on the [Simple Features](https://en.wikipedia.org/wiki/Simple_Features) 
#' standard.
#' 
#' If \code{x_colName} and \code{y_colName} are both provided, a `POINT` geometry 
#' will be constructed based on these columns.
#'
#' @details
#' For list of files supported see link below.
#' <https://DuckDB.org/docs/extensions/spatial.html#st_read---read-spatial-value-from-files>
#'
#'
#' @return \code{\link{dbSpatial}} object.
#' @export
#'
#' @family dbSpatial
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
#'           x_colName = "x",
#'           y_colName = "y",
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
    name <- dbplyr::remote_name(value) # will return NULL if passing VIEW
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
      if(!x_colName %in% names(value) || !y_colName %in% names(value)){
        stop("x_colName and y_colName must be columns in 'value'.")
      }
      
      DBI::dbWriteTable(
        conn = conn,
        name = name,
        value = value,
        overwrite = overwrite
      )
      .add_pointGeom(conn, name, x_colName, y_colName, geomName, overwrite)
    } else if (inherits(value, "character")){
      .st_read(
        conn = conn,
        name = name,
        value = value,
        overwrite = overwrite,
        x_colName = x_colName,
        y_colName = y_colName,
        geomName = geomName,
        return = FALSE
      )
    }
  } else if (is.character(value)) {
    .st_read(conn = conn, name = name, value = value, overwrite = overwrite)
  } else if (inherits(value, c("SpatVector", "SpatRaster", "sf"))) {
    as_dbSpatial(
      rSpatial = value,
      conn = conn,
      name = name,
      overwrite = overwrite
    )
  } else if (inherits(value, "tbl_duckdb_connection")){
    .handle_tbl(conn, value)
  } else if (inherits(value, "sdf")) {
    stop("Support for 'sdf' objects is not yet implemented.")
  } else {
    stop("Invalid 'value' paramater.")
  }
  
  tbl <- dplyr::tbl(conn, name)
  
  # s3 object construction
  # res <- structure(
  #   list(
  #     conn = conn,
  #     name = name,
  #     value = value
  #     ),
  #   class = "dbSpatial"
  # )
  
  # S4 object creation
  res <- new("dbSpatial",
             conn = conn,
             name = name,
             value = tbl)
  
  return(res)
}

## Internal functions ####

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

.add_pointGeom <- function(conn,
                           name,
                           x_colName,
                           y_colName,
                           geomName,
                           overwrite) {
  # First, check if the column already exists
  check_sql <- glue::glue("SELECT COUNT(*) FROM information_schema.columns 
                           WHERE table_name = '{name}' AND column_name = '{geomName}'")
  
  column_exists <- DBI::dbGetQuery(conn, check_sql)[[1]] > 0
  
  if (column_exists & !overwrite) {
    stop(
      "Column already exists with name: ",
      geomName,
      ". Please choose a different name or set 'overwrite' to TRUE."
    )
  } else if (column_exists & overwrite) {
    sql <- glue::glue("UPDATE {name} 
                       SET {geomName} = ST_Point({x_colName}, {y_colName})")
  } else {
    # If the column doesn't exist, add it
    sql <- glue::glue("ALTER TABLE {name} 
                       ADD COLUMN {geomName} GEOMETRY;
                       UPDATE {name} 
                       SET {geomName} = ST_Point({x_colName}, {y_colName})")
  }
  
  invisible(DBI::dbExecute(conn, sql))
}


#' @description internal func to get first geometry column name
#' @details assumes geometry column is of type list
#' @noRd
#' @keywords internal
.get_geomName <- function(x){
  geom_name <- x |> 
    sapply(class) |> 
    (\(x) names(x)[x == "list"])() |> 
    (\(x) if(length(x) > 0) x[1] else NULL)() # first geometry col is extent
  
  return(geom_name)
}
