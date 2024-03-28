#' Find distance between `geometries` in two dbSpatial objects
#'
#' @param g1 A \code{\link{dbSpatial}} object.
#' @param g1_geom_colName \code{character}. The `geometry` column name in `g1`. 
#' default: "geom"
#' @param g1_cols_keep \code{character vector}. The column names in `g1` to keep
#' after the operation. default: 'all' for all columns
#' @param g2 \code{\link{dbSpatial}} object. 
#' @param g2_geom_colName \code{character}. The `geometry` column name in `g2`. 
#' default: "geom"
#' @param g2_cols_keep \code{character vector}. The column names in `g2` to keep
#' after the operation. default: 'all' for all columns
#' @param overwrite \code{logical}. If TRUE, overwrite an existing table with the
#' same `output_tblName`. default: FALSE
#' @param output_tblName \code{character}. The name of the table to store the 
#' resulting data. default: "distance_geom"
#' @family spatial_relationships
#'
#' @description
#' <https://postgis.net/docs/ST_Distance.html>
#' Adds column 'st_distance' to the resulting table containing the distance
#' between the geometries in g1 and g2.
#'
#' @return tbl_dbi
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
#' res <- st_distance(g1 = points, 
#'                    g1_cols_keep = c("name"), 
#'                    g2 = points2,
#'                    overwrite = TRUE)
#' 
#' res
st_distance <- function(g1,
                        g1_geom_colName = "geom",
                        g1_cols_keep = "all",
                        g2,
                        g2_geom_colName = "geom",
                        g2_cols_keep = "all",
                        overwrite = FALSE,
                        output_tblName = "distance_geom"){
  # Check inputs
  .check_con(conn = g1$src$con)
  .check_con(conn = g2$src$con)
  .check_tbl(tbl = g1)
  .check_geomName(tbl = g1, geomName = g1_geom_colName)
  .check_cols_keep(tbl = g1, cols_keep = g1_cols_keep)
  .check_tbl(tbl = g2)
  .check_geomName(tbl = g2, geomName = g2_geom_colName)
  .check_cols_keep(tbl = g2, cols_keep = g2_cols_keep)
  .check_con_shared(conn1 = g1$src$con, conn2 = g2$src$con)
  .check_overwrite(conn = g1$src$con,
                   overwrite = overwrite,
                   name = output_tblName)
  .check_name(name = output_tblName)
  
  # Load the DuckDB Spatial extension
  suppressMessages(loadSpatial(con = g1$src$con))
  
  # Update SQL statement depending on g1_cols_keep and g2_cols_keep
  tblName_g1 <- dbplyr::remote_name(g1)
  tblName_g2 <- dbplyr::remote_name(g2)
  sql <- .gen_sql_query(output_tblName = output_tblName,
                        tblName_g1 = tblName_g1,
                        tblName_g2 = tblName_g2,
                        g1_geom_colName = g1_geom_colName,
                        g2_geom_colName = g2_geom_colName,
                        g1_cols_keep = g1_cols_keep,
                        g2_cols_keep = g2_cols_keep,
                        st_name = "st_distance",
                        overwrite = overwrite)

  # add 'st_distance' col logic to sql string
  lines <- strsplit(sql, "\n")[[1]]
  lines[2] <- paste0(lines[2], 
                     ", ",
                     glue::glue("st_distance(g1.{g1_geom_colName}, g2.{g2_geom_colName}) AS st_distance"))
  lines <- head(lines, -1) # remove where clause
  sql <- paste(lines, collapse = " ")

  duckdb::dbSendQuery(g1$src$con, sql)
  
  res <- dplyr::tbl(g1$src$con, output_tblName)
  
  return(res)
}
