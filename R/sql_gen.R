#' Internal function to execute sql query on ST_* spatial rel funcs
#'
#' @param name The name of the output table to be created or replaced.
#' @param tblName_g1 The name of the first input table.
#' @param tblName_g2 The name of the second input table.
#' @param g1_geomName The name of the geometry column in the first input table.
#' @param g2_geomName The name of the geometry column in the second input table.
#' @param g1_cols_keep Columns from the first table to keep in the output table. Can be a character vector of column names or "all" to include all columns.
#' @param g2_cols_keep Columns from the second table to keep in the output table. Can be a character vector of column names or "all" to include all columns.
#' @param st_name The name of the spatial function to use for determining intersections.
#' @param overwrite Logical; if TRUE, the output table will be replaced if it already exists.
#'
#' @details
#' This function generates an SQL query that creates or replaces a new table
#' based on the specified st_name function passed. The new table will contain
#' selected columns from both input tables.
#'
#' @return A character string containing the SQL query.
#' @keywords internal
#' @noRd
.gen_sql_query <- function(name,
                           tblName_g1,
                           tblName_g2,
                           g1_geomName,
                           g2_geomName,
                           g1_cols_keep,
                           g2_cols_keep,
                           st_name,
                           overwrite,
                           g2_suffix = ".2") {
  
  # Helper function to construct col strings
  generate_cols_selection <- function(prefix, cols_keep) {
    if (identical(cols_keep, "all")) {
      return(paste0(prefix, ".*"))
    } else if(all(cols_keep == "none")){
      return(paste0(""))
    } 
    else {
      return(paste0(prefix, ".", cols_keep, collapse = ", "))
    }
  }
  
  # Generate column selection strings
  g1_cols <- generate_cols_selection("g1", g1_cols_keep)
  g2_cols <- generate_cols_selection("g2", g2_cols_keep)
  
  # Construct the SQL query
  sql_template <- "CREATE {replace} VIEW {name} AS
                   SELECT {g1_cols}, {g2_cols}
                   FROM {tblName_g1} g1, {tblName_g2} g2
                   WHERE {st_name}(g1.{g1_geomName}, g2.{g2_geomName});"
  
  replace_clause <- ifelse(overwrite, "OR REPLACE", "")
  sql <- glue::glue(sql_template,
                    replace = replace_clause,
                    name = name %||% "DEFAULT_TABLE",
                    g1_cols = g1_cols %||% "DEFAULT_COLS",
                    g2_cols = g2_cols %||% "DEFAULT_COLS",
                    tblName_g1 = tblName_g1 %||% "DEFAULT_G1_TABLE",
                    tblName_g2 = tblName_g2 %||% "DEFAULT_G2_TABLE",
                    st_name = st_name %||% "DEFAULT_st",
                    g1_geomName = g1_geomName %||% "geom",
                    g2_geomName = g2_geomName %||% "geom")
  
  return(sql)
}
