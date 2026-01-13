test_that("dbSpatial constructor works", {
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

  expect_s4_class(pts, "dbSpatial")
  expect_true("geom" %in% colnames(pts[]))
})

test_that("basic spatial functions work", {
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

  # accessors
  expect_s4_class(st_x(pts), "dbSpatial")
  expect_s4_class(st_y(pts), "dbSpatial")
  expect_s4_class(st_npoints(pts), "dbSpatial")

  # measurements
  expect_s4_class(st_area(pts), "dbSpatial")

  # geometry ops
  expect_s4_class(st_buffer(pts, dist = 1), "dbSpatial")
  expect_s4_class(st_centroid(pts), "dbSpatial")

  # bbox
  bb <- st_bbox(pts)
  expect_s3_class(bb, "bbox")
  expect_equal(as.numeric(bb["xmin"]), 0)
  expect_equal(as.numeric(bb["xmax"]), 20)
})

test_that("st_geometrytype returns expected types lazily", {
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

  gt_tbl <- st_geometrytype(pts)
  expect_true(inherits(gt_tbl, "tbl"))

  first_type <- gt_tbl |>
    head(n = 1) |>
    dplyr::collect() |>
    dplyr::pull(geom_type) |>
    as.character()

  expect_true(grepl("POINT", first_type))
})

test_that("st_join works with different predicates", {
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

  # st_join with st_intersects - self-join returns 3 rows (each point intersects itself)
  res <- st_join(pts, pts, join = sf::st_intersects)
  expect_s4_class(res, "dbSpatial")
  expect_equal(nrow(dplyr::collect(res[])), 3)
})

test_that("unsupported args warn", {
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

  expect_warning(st_buffer(pts, dist = 1, endCapStyle = "SQUARE"))
  expect_warning(st_centroid(pts, garbage = 1))
  expect_warning(st_simplify(pts, preserveTopology = TRUE))
})
