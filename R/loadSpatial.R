#' Install and/or load DuckDB spatial extension
#'
#' @param conn duckdb connection
#' @param extension_directory Directory where DuckDB should install extensions.
#'   Defaults to a directory in the R session temporary directory. Set the
#'   `dbSpatial.extension_directory` option to use a different location.
#'
#' @return No return value, called for side effects. Installs and loads the
#'   DuckDB spatial extension for `conn`.
#' @export
#' @family duckdb-ext
#' @examples
#' if (interactive() && requireNamespace("duckdb", quietly = TRUE)) {
#'   duckdb_conn = DBI::dbConnect(duckdb::duckdb(), ":memory:")
#'   DBI::dbExecute(duckdb_conn, "SET threads = 1")
#'   loadSpatial(conn = duckdb_conn)
#'   DBI::dbDisconnect(duckdb_conn, shutdown = TRUE)
#' }
loadSpatial <- function(
  conn,
  extension_directory = getOption(
    "dbSpatial.extension_directory",
    file.path(tempdir(), "dbSpatial-duckdb-extensions")
  )
) {
  # input validation
  .check_con(conn)

  if (!is.null(extension_directory)) {
    .set_duckdb_extension_directory(conn, extension_directory)
  }

  invisible(DBI::dbExecute(conn, "INSTALL spatial"))
  invisible(DBI::dbExecute(conn, "LOAD spatial"))

  message("DuckDB spatial extension installed and loaded")
  invisible(NULL)
}

.set_duckdb_extension_directory <- function(conn, extension_directory) {
  if (
    !is.character(extension_directory) ||
      length(extension_directory) != 1L ||
      is.na(extension_directory)
  ) {
    stop("extension_directory must be a single non-missing character string.")
  }

  if (!dir.exists(extension_directory)) {
    dir.create(extension_directory, recursive = TRUE, showWarnings = FALSE)
  }
  if (!dir.exists(extension_directory)) {
    stop("Could not create extension_directory: ", extension_directory)
  }

  extension_directory <- normalizePath(
    extension_directory,
    winslash = "/",
    mustWork = FALSE
  )
  query <- sprintf(
    "SET extension_directory = %s",
    .duckdb_sql_string(extension_directory)
  )
  invisible(DBI::dbExecute(conn, query))
}

.duckdb_sql_string <- function(x) {
  paste0("'", gsub("'", "''", x, fixed = TRUE), "'")
}
