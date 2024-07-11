ST_Point <- function(conn, name, x_colName, y_colName){
  # input validation
  .check_con(conn)
  .check_name(name)
  
  # create point geometry
  point_query = paste0("CREATE OR REPLACE VIEW ", name, " AS ",
                       " SELECT *, ST_Point(", x_colName, ", ", y_colName, 
                       ") AS geom FROM ", name)
  invisible(DBI::dbExecute(conn, point_query))
  
  # Show preview
  dplyr::name(conn, name)
  
}