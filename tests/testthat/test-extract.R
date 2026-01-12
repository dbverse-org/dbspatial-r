test_that("$ extracts column values", {
  skip_if_not_installed("duckdb")

  con <- DBI::dbConnect(duckdb::duckdb())
  on.exit(DBI::dbDisconnect(con, shutdown = TRUE))

  df <- data.frame(id = 1:3, x = c(0, 10, 20), y = c(0, 10, 20))
  pts <- dbSpatial(
    conn = con,
    name = "test_pts",
    value = df,
    x_colName = "x",
    y_colName = "y",
    overwrite = TRUE
  )

  expect_identical(pts$id, 1:3)
})
