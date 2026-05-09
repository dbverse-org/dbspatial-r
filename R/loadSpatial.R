#' Install and/or load DuckDB spatial extension
#'
#' @param conn duckdb connection
#'
#' @return NULL
#' @export
#' @family duckdb-ext
#' @examples
#' if (requireNamespace("duckdb", quietly = TRUE)) {
#'   duckdb_conn = DBI::dbConnect(duckdb::duckdb(), ":memory:")
#'   loadSpatial(conn = duckdb_conn)
#'   DBI::dbDisconnect(duckdb_conn, shutdown = TRUE)
#' }
loadSpatial <- function(conn) {
  # input validation
  .check_con(conn)

  # Install spatial extension
  query = "INSTALL spatial; LOAD spatial;"
  invisible(DBI::dbExecute(conn, query))

  message("DuckDB spatial extension installed and loaded")
}
