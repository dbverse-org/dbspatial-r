#' Find difference in `geometries` between two dbSpatial objects
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
#' resulting data. default: "difference_geom"
#' @family spatial_relationships
#'
#' @description
#' https://postgis.net/docs/ST_Difference.html
#' Adds column 'st_difference' to the resulting table containing the difference
#' between the geometries in g1 and g2.
#'
#' @return tbl_dbi
#' @export
#'
#' @examples
#' con = DBI::dbConnect(duckdb::duckdb(), ":memory:")
#' 
#' polys <- dbSpatial(conn = con,
#'                    name = "polys",
#'                    value = system.file("data", "dummy_polygons.geojson", package = "dbSpatial"),
#'                    overwrite = TRUE,
#'                    x_colName = "x",
#'                    y_colName = "y")
#'
#' polys2 <- dbSpatial(conn = con,
#'                    name = "polys2",
#'                    value = system.file("data", "dummy_polygons.geojson", package = "dbSpatial"),
#'                    overwrite = TRUE,
#'                    x_colName = "x",
#'                    y_colName = "y")
#' 
#' res <- st_difference(g1 = polys, 
#'                      g2 = polys2,
#'                      overwrite = TRUE)
#' 
#' res
st_difference <- function(g1,
                          g1_geom_colName = "geom",
                          g1_cols_keep = "all",
                          g2,
                          g2_geom_colName = "geom",
                          g2_cols_keep = "all",
                          overwrite = FALSE,
                          output_tblName = "difference_geom"){
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
                        st_name = "st_difference",
                        overwrite = overwrite)
  
  # add 'st_distance' col logic to sql string
  lines <- strsplit(sql, "\n")[[1]]
  lines[2] <- paste0(lines[2], 
                     ", ",
                     glue::glue("st_difference(g1.{g1_geom_colName}, g2.{g2_geom_colName}) AS st_difference"))
  lines <- head(lines, -1) # remove where clause
  sql <- paste(lines, collapse = " ")
  
  duckdb::dbSendQuery(g1$src$con, sql)
  
  res <- dplyr::tbl(g1$src$con, output_tblName)
  
  return(res)
}
