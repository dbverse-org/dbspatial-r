#' @title Convert an sf or terra object to a `dbSpatial` object
#' @description
#' Create a \code{\link{dbSpatial}} object from an \code{sf} or \code{terra} object.
#'
#' @details
#' Writes the `rSpatial` object to a temporary DuckDB table and computes the
#' table in the database with the specified `name` and the geometry column as
#' `geom`.
#'
#' @param rSpatial \code{sf} or \code{terra} object.
#' @param conn A DBI connection object, as returned by `DBI::dbConnect()`.
#' @param name \code{a character string} with the unquoted DBMS table name, e.g. "table_name"
#' @param overwrite \code{logical}. Overwrite existing table. default = FALSE.
#' @param ... Additional arguments to be passed
#' @return A [`dbSpatial`] object backed by table `name` in `conn`, with the
#'   geometry column stored as `geom`.
#' @family dbSpatial
#' @export
#' @examples
#' if (interactive() && requireNamespace("duckdb", quietly = TRUE)) {
#'   coordinates <- data.frame(x = c(100, 200, 300), y = c(500, 600, 700))
#'   attributes <- data.frame(id = 1:3, name = c("A", "B", "C"))
#'
#'   # Combine the coordinates and attributes
#'   dummy_data <- cbind(coordinates, attributes)
#'
#'   # Create a SpatVector from the data.frame
#'   dummy_spatvector <- terra::vect(dummy_data, geom = c("x", "y"))
#'
#'   # Set db connection
#'   duckdb_conn = DBI::dbConnect(duckdb::duckdb(), ":memory:")
#'   DBI::dbExecute(duckdb_conn, "SET threads = 1")
#'
#'   dbSpatial <- as_dbSpatial(rSpatial = dummy_spatvector,
#'                            conn = duckdb_conn,
#'                            name = "dummy_spatvector",
#'                            overwrite = TRUE)
#'   dbSpatial
#'   DBI::dbDisconnect(duckdb_conn, shutdown = TRUE)
#' }
as_dbSpatial <- function(rSpatial, conn, name, overwrite = FALSE, ...) {
  # input validation
  .check_con(conn = conn)
  .check_name(name = name)
  .check_overwrite(conn = conn, name = name, overwrite = overwrite)

  # Load spatial extension
  suppressMessages(loadSpatial(conn = conn))

  # check that rSpatial is of class sf or terra
  if (!(inherits(rSpatial, "sf") || inherits(rSpatial, "SpatVector"))) {
    stop("rSpatial must be an {sf} or {terra} object.")
  }

  if (inherits(rSpatial, "SpatRaster")) {
    stop("Support for {terra} SpatRaster objects not yet implemented.")
  }

  sf_obj <- if (inherits(rSpatial, "sf")) {
    rSpatial
  } else {
    sf::st_as_sf(rSpatial)
  }

  temp_name <- paste0(
    "__dbspatial_",
    gsub("[^A-Za-z0-9_]", "_", name),
    "_",
    sample.int(.Machine$integer.max, 1)
  )
  on.exit({
    if (DBI::dbExistsTable(conn, temp_name)) {
      DBI::dbRemoveTable(conn, temp_name)
    }
  }, add = TRUE)

  spatial_df <- sf::st_drop_geometry(sf_obj)
  spatial_df$geometry <- sf::st_as_text(sf::st_geometry(sf_obj))
  DBI::dbWriteTable(conn, temp_name, spatial_df, temporary = TRUE)

  tbl <- dplyr::tbl(conn, temp_name) |>
    dplyr::mutate(geom = dbplyr::sql("ST_GeomFromText(geometry)")) |>
    dplyr::select(-geometry) |>
    dplyr::compute(overwrite = overwrite, name = name)

  res <- dbSpatial(value = tbl, name = name)

  return(res)
}
