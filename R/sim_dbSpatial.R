#' Simulate basic dbSpatial object
#'
#' @return A dbSpatial object
#' @keywords internal
.sim_dbSpatial <- function(){
  test_data = data.frame(
    x = 1:100,
    y = 1:100
  )
  
  con = DBI::dbConnect(duckdb::duckdb(), ":memory:")
  
  res <- dbSpatial(conn = con,
                   name = "test_data",
                   value = test_data,
                   x_colName = "x",
                   y_colName = "y")
  
  return(res)
}