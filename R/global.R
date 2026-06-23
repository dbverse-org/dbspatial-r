#' dbSpatial Package Global Options
#' @description Global options to control package behavior.
#' @details Use `options()` to set the below options.
#' @section Options:
#' * `dbSpatial.max_print`: integer. Max characters for WKT in show method (default 30).
#' * `dbSpatial.max_mem_convert`: numeric. Max bytes for implicit coercion (default 8GB).
#' * `dbSpatial.verbose`: logical. Print info messages during coercion (default TRUE).
#' * `dbSpatial.extension_directory`: character. Directory used by DuckDB to
#'   install extensions in `loadSpatial()` (default: a directory under
#'   `tempdir()`).
#'
#' @examples
#' options(dbSpatial.max_print = 50)
#' options(dbSpatial.max_mem_convert = 16 * 1024^3)
#' options(dbSpatial.verbose = FALSE)
#' options(dbSpatial.extension_directory = file.path(tempdir(), "duckdb-extensions"))
#' @name dbSpatial_options
#' @aliases dbSpatial-options
#' @concept options
NULL

utils::globalVariables(c(
  ":=", "geom_type", "geometry", "n", "ST_AsWKB", "ST_GeometryType",
  "st_xmin", "st_ymin", "x", "y"
))
