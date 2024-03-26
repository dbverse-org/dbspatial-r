#' Intersect two dbSpatial objects
#'
#' @param p1 A \code{\link{dbSpatial}} object containing a `geometry` column in a database.
#' @param p1_geom_colName The `geometry` column name in p1. default: "geom"
#' @param p1_cols_keep The column names in p1 to keep after the intersection. default: all columns
#' @param p2 A \code{\link{dbSpatial}} object containing a `geometry` column in a database.
#' @param p2_geom_colName The `geometry` column name in p2. default: "geom"
#' @param p2_cols_keep The column names in p2 to keep after the intersection. default: all columns
#' @param output_tblName The name of the table to store the intersected geom data. default: "intersect_geom"
#' @keywords geom_predicates
#'
#' @description
#' This function intersects two \code{\link{dbSpatial}} objects with `geometry` columns in a database.
#'
#' @details
#' The `st_intersects()` function is used to intersect sets of `geometry` point 
#' and/or polygon data between \code{\link{dbSpatial}} objects. `p1` and `p2` 
#' \code{\link{dbSpatial}} objects must share the same database connection.
#'
#' By default this function will overwrite an existing table with the same name.
#'
#' @return A \code{\link{dbSpatial}} object containing specified columns from 
#' the geometry intersection.
#' @export
#'
#' @examples
#' con = DBI::dbConnect(duckdb::duckdb(), ":memory:")
#' 
#' coordinates <- data.frame(x = c(100, 200, 300), y = c(500, 600, 700))
#' attributes <- data.frame(id = 1:3, name = c("A1", "B1", "C1"))
#'
#' # Combine the coordinates and attributes
#' dummy_data <- cbind(coordinates, attributes)
#'  
#' points <- dbSpatial(conn = con,
#'                     name = "points", 
#'                     value = dummy_data, 
#'                     overwrite = TRUE, 
#'                     x_colName = "x", 
#'                     y_colName = "y")
#'
#' # preview                     
#' points |> 
#'   dplyr::mutate(geom_text = ST_AsText(geom))
#'                     
#' # Create a second set of points, with B1 and C1 translated by + 100
#' dummy_data2 <- dummy_data
#' dummy_data2[c(2,3),c(1,2)] <- dummy_data2[c(2,3),c(1,2)] + 150
#' dummy_data2$name <- c('A2', 'B2', 'C2')
#' 
#' points2 <- dbSpatial(conn = con,
#'                     name = "points2", 
#'                     value = dummy_data2, 
#'                     overwrite = TRUE, 
#'                     x_colName = "x", 
#'                     y_colName = "y")
#' # preview                     
#' points2 |> 
#'   dplyr::mutate(geom_text = ST_AsText(geom))
#' 
#' points_intersect <- st_intersects(p1 = points, 
#'                                   p1_cols_keep = c("name"), 
#'                                   p2 = points2)
#' 
#' points_intersect
st_intersects <- function(p1,
                          p1_geom_colName = "geom",
                          p1_cols_keep = NULL,
                          p2,
                          p2_geom_colName = "geom",
                          p2_cols_keep = NULL,
                          output_tblName = "intersect_geom"){
  # Check inputs
  # TODO: Add checks for p1 and p2 classes
  con_p1 <- p1$src$con
  con_p2 <- p2$src$con
  
  # Check if connections are valid
  .check_con(con_p1)
  .check_con(con_p2)
  
  # TODO: check if p1 and p2 share the same connection
  # How to extract absolute path of the con object from p1, p2?
  if(!all.equal(con_p1, con_p2)){
    stop("p1 and p2 must be in the same connection.")
  }
  
  tblName_p1 <- dbplyr::remote_name(p1)
  tblName_p2 <- dbplyr::remote_name(p2)
  .check_name(tblName_p1)
  .check_name(tblName_p2)
  
  # Load the DuckDB Spatial extension
  suppressMessages(loadSpatial(con = con_p1))
  
  # Update SQL statement depending on p1_cols_keep and p2_cols_keep
  if(is.null(p1_cols_keep) & is.null(p2_cols_keep)){
    # keep all of the columns
    sql <- glue::glue("CREATE OR REPLACE TABLE {output_tblName} AS
                       SELECT p1.*, p2.*
                       FROM {tblName_p1} p1, {tblName_p2} p2
                       WHERE ST_Intersects(p1.{p1_geom_colName}, p2.{p2_geom_colName});")
  } else if(!is.null(p1_cols_keep) & !is.null(p2_cols_keep)){
    # check if p1_cols_keep and p2_cols_keep are valid character vectors
    if(!is.character(p1_cols_keep) | !is.character(p2_cols_keep)){
      stop("p1_cols_keep and p2_cols_keep must be character vectors.")
    }
    
    p1_cols <- paste0("p1.", p1_cols_keep, collapse = ", ")
    p2_cols <- paste0("p2.", p2_cols_keep, collapse = ", ")
    sql <- glue::glue("CREATE OR REPLACE TABLE {output_tblName} AS
                       SELECT {p1_cols}, {p2_cols}
                       FROM {tblName_p1} p1, {tblName_p2} p2
                       WHERE ST_Intersects(p1.{p1_geom_colName}, p2.{p2_geom_colName});")
  } else if(is.null(p1_cols_keep) & !is.null(p2_cols_keep)){
    # check if p2_cols_keep is a valid character vector
    if(!is.character(p2_cols_keep)){
      stop("p2_cols_keep must be a character vector.")
    }
    
    p2_cols <- paste0("p2.", p2_cols_keep, collapse = ", ")
    sql <- glue::glue("CREATE OR REPLACE TABLE {output_tblName} AS
                       SELECT p1.*, {p2_cols}
                       FROM {tblName_p1} p1, {tblName_p2} p2
                       WHERE ST_Intersects(p1.{p1_geom_colName}, p2.{p2_geom_colName});")
  } else if (!is.null(p1_cols_keep) & is.null(p2_cols_keep)){
    # check if p1_cols_keep is a valid character vector
    if(!is.character(p1_cols_keep)){
      stop("p1_cols_keep must be a character vector.")
    }
    p1_cols <- paste0("p1.", p1_cols_keep, collapse = ", ")
    sql <- glue::glue("CREATE OR REPLACE TABLE {output_tblName} AS
                       SELECT {p1_cols}, p2.*
                       FROM {tblName_p1} p1, {tblName_p2} p2
                       WHERE ST_Intersects(p1.{p1_geom_colName}, p2.{p2_geom_colName});")
  }
  
  # Execute the query
  # NOTE: using DBI::dbSendQuery crashes w/ ST_Intersects() 02.15.2024
  duckdb::dbSendQuery(con_p1, sql)
  
  # Rename geometry column names
  if(p1_geom_colName == p2_geom_colName &
     p2_geom_colName %in% p1_cols_keep &
     p1_geom_colName %in% p2_cols_keep){
    sql <- glue::glue('ALTER TABLE {output_tblName}
                       RENAME COLUMN "geom:1" TO geom_p2;')
    duckdb::dbSendQuery(con_p1, sql)
  }
  
  res <- dplyr::tbl(con_p1, output_tblName)
  
  return(res)
}
