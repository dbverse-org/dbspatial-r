#' Simulate basic dbSpatial object
#' @param geom whether to load 'point' or 'polygon' GEOMETRY test file
#' @return A dbSpatial object
#' @keywords internal
.sim_dbSpatial <- function(geom = c("point", "polygon")){
  con = DBI::dbConnect(duckdb::duckdb(), ":memory:")
  geom <- match.arg(geom)
  loadSpatial(con)
  
  if(geom == "point"){
    test_data = data.frame(
      x = 1:100,
      y = 1:100
    )
    
    res <- dbSpatial(conn = con,
                     name = "test_data",
                     value = test_data,
                     x_colName = "x",
                     y_colName = "y",
                     overwrite = TRUE)
  } else {
    poly_file <- system.file("extdata",
                             "polygon.geojson",
                             package = "dbSpatial")
    
    res <- dbSpatial(conn = con,
                     name = "test_data",
                     value = poly_file,
                     overwrite = TRUE)
  }
  
  return(res)
}