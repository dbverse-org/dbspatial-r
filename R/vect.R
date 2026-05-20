#' @import methods
#' @importFrom terra vect
#' @importFrom tidyselect everything
NULL

#' @title Create SpatVector objects
#' @param x A [`dbSpatial`] object to convert into a [`terra::SpatVector`] object
#' @param select Columns to retain in output (default: all columns)
#' @param ... Additional arguments passed to [`sf::st_as_sf`]
#' @return A [`terra::SpatVector`] containing the selected columns and geometry
#'   materialized from `x`.
#' @family dbSpatial
#'
#' @examples
#' \donttest{
#' if (interactive() && requireNamespace("duckdb", quietly = TRUE)) {
#'   point_data <- data.frame(x = c(100, 200), y = c(500, 600), id = 1:2)
#'   point_vect <- terra::vect(point_data, geom = c("x", "y"))
#'   duckdb_conn <- DBI::dbConnect(duckdb::duckdb(), ":memory:")
#'   DBI::dbExecute(duckdb_conn, "SET threads = 1")
#'   dbs <- as_dbSpatial(point_vect, conn = duckdb_conn, name = "point_vect",
#'                       overwrite = TRUE)
#'   terra::vect(dbs)
#'   DBI::dbDisconnect(duckdb_conn, shutdown = TRUE)
#' }
#' }
#'
#' @export
setMethod(
  "vect",
  signature = "dbSpatial",
  function(x, select = tidyselect::everything(), ...) {
    .vect(x, select = {{ select }}, ...)
  }
)

#' @keywords internal
.vect <- function(x, select = tidyselect::everything(), ...) {
  # Convert with column selection
  sf_obj <- sf::st_as_sf(x, select = {{ select }}, ...)

  return(terra::vect(sf_obj))
}
