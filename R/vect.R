#' @import methods
#' @importFrom terra vect
#' @importFrom tidyselect everything
NULL

#' @title Create SpatVector objects
#' @param x A [`dbSpatial`] object to convert into a [`terra::SpatVector`] object
#' @param select Columns to retain in output (default: all columns)
#' @param ... Additional arguments passed to [`sf::st_as_sf`]
#' @family dbSpatial
#'
#' @examples
#' if (requireNamespace("duckdb", quietly = TRUE)) {
#'   dbs <- dbSpatial:::.sim_dbSpatial()
#'   terra::vect(dbs)
#'   DBI::dbDisconnect(dbProject::conn(dbs), shutdown = TRUE)
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
