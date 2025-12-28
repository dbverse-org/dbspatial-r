#' dbSpatial Package Global Options
#' @description The following global options can be modified to control the
#' behavior of the [`dbSpatial`] package.
#' @details Use `options()` to set the below options.
#' @section Options:
#' * [`dbSpatial.max_mem_convert`]: numeric. Maximum size (in bytes) allowed for
#' implicit conversion of `dbSpatial` to in-memory object (SpatVector/sf). Default is 8 * 1024^3 (8GB).
#' * [`dbSpatial.verbose`]: logical. If `TRUE` (default), prints informative messages
#' during implicit coercion.
#'
#' @name dbSpatial_options
#' @keywords internal
NULL