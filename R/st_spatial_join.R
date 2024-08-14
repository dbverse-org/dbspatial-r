#' Base function for spatial joins
#' 
#' @description
#' Internal base function for spatial joins. 
#' 
#' @details 
#' Returns a VIEW of the spatial join. Must compute to save results.
#' 
#' @param g1 A \code{\link{dbSpatial}} object.
#' @param g1_geomName \code{character}. The `geometry` column name in `g1`. Default: "geom".
#' @param g1_cols_keep \code{character vector}. The column names in `g1` to keep. Default: "all".
#' @param g2 A \code{\link{dbSpatial}} object.
#' @param g2_geomName \code{character}. The `geometry` column name in `g2`. Default: "geom".
#' @param g2_cols_keep \code{character vector}. The column names in `g2` to keep. Default: "all".
#' @param overwrite \code{logical}. If \code{TRUE}, overwrite existing table. Default: \code{FALSE}.
#' @param name \code{character}. The name of the output table.
#' @param st_name \code{character}. The name of the spatial join function to use.
#' @param ... Additional arguments passed to \code{\link{duckdb::dbSendQuery}}.
#' 
#' @return `dbSpatial` object
#' @keywords internal
.st_spatial_join <- function(g1,
                             g1_geomName = "geom",
                             g1_cols_keep = "all",
                             g2,
                             g2_geomName = "geom",
                             g2_cols_keep = "all",
                             overwrite = FALSE,
                             name,
                             st_name,
                             ...) {
  # Check inputs
  con1 = dbplyr::remote_con(g1[])
  con2 = dbplyr::remote_con(g2[])
  .check_con(conn = con1)
  .check_con(conn = con2)
  .check_tbl(tbl = g1[])
  .check_geomName(value = g1[], geomName = g1_geomName)
  .check_cols_keep(tbl = g1[], cols_keep = g1_cols_keep)
  .check_tbl(tbl = g2[])
  .check_geomName(value = g2[], geomName = g2_geomName)
  .check_cols_keep(tbl = g2[], cols_keep = g2_cols_keep)
  .check_con_shared(conn1 = con1, conn2 = con2)
  .check_overwrite(conn = con1,
                   overwrite = overwrite,
                   name = name)
  .check_name(name = name)
  
  # Load the DuckDB Spatial extension
  suppressMessages(loadSpatial(con = con1))
  
  # Update SQL statement depending on g1_cols_keep and g2_cols_keep
  tblName_g1 <- dbplyr::remote_name(g1[])
  tblName_g2 <- dbplyr::remote_name(g2[])
  if(is.null(tblName_g1) || is.null(tblName_g2)){
    stop("Unable to determine table names.")
  }
  
  sql <- .gen_sql_query(name = name,
                        tblName_g1 = tblName_g1,
                        tblName_g2 = tblName_g2,
                        g1_geomName = g1_geomName,
                        g2_geomName = g2_geomName,
                        g1_cols_keep = g1_cols_keep,
                        g2_cols_keep = g2_cols_keep,
                        st_name = st_name,
                        overwrite = overwrite)
  
  duckdb::dbSendQuery(con1, sql) 
  
  out_tbl <- dplyr::tbl(con1, name)
  
  res <- dbSpatial(conn = con1, name = name, value = out_tbl)
  
  return(res)
}