#' Simulate basic dbSpatial object
#' @param geom whether to load 'point' or 'polygon' GEOMETRY test file
#' @return A dbSpatial object
#' @details Polygon data is created dynamically using sf rather than loading
#'   from inst/extdata/polygon.geojson. This avoids issues with system.file()
#'   returning an empty string when called from dependent packages during
#'   R CMD check (before dbSpatial is fully installed to the test library).
#' @keywords internal
.sim_dbSpatial <- function(geom = c("point", "polygon")) {
  con = DBI::dbConnect(duckdb::duckdb(), ":memory:")
  DBI::dbExecute(con, "SET threads = 1")
  geom <- match.arg(geom)
  loadSpatial(con)

  if (geom == "point") {
    test_data = data.frame(
      x = 1:100,
      y = 1:100
    )

    res <- dbSpatial(
      conn = con,
      name = "test_data",
      value = test_data,
      x_colName = "x",
      y_colName = "y",
      overwrite = TRUE
    )
  } else {
    # Create polygon data dynamically to avoid system.file() issues
    # during R CMD check and devtools::load_all()
    # Create 6 polygons to support split tests
    poly_coords <- list(
      rbind(c(0, 0), c(10, 0), c(10, 10), c(0, 10), c(0, 0)),
      rbind(c(20, 20), c(30, 20), c(30, 30), c(20, 30), c(20, 20)),
      rbind(c(40, 40), c(50, 40), c(50, 50), c(40, 50), c(40, 40)),
      rbind(c(60, 60), c(70, 60), c(70, 70), c(60, 70), c(60, 60)),
      rbind(c(80, 80), c(90, 80), c(90, 90), c(80, 90), c(80, 80)),
      rbind(c(100, 100), c(110, 100), c(110, 110), c(100, 110), c(100, 100))
    )
    polys <- lapply(poly_coords, function(coords) {
      sf::st_polygon(list(coords))
    })
    sf_polys <- sf::st_sfc(polys, crs = 4326)
    poly_sf <- sf::st_sf(
      poly_ID = paste0("poly_", 1:6),
      name = c("A", "B", "C", "D", "E", "F"),
      geometry = sf_polys
    )

    res <- dbSpatial(
      conn = con,
      name = "test_data",
      value = poly_sf,
      overwrite = TRUE
    )
  }

  return(res)
}
