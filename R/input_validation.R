#' Input validation for data arg
#' @keywords internal
#' @noRd
.check_value <- function(value) {
  is_tbl_dbi <- inherits(value, "tbl_dbi")
  is_df <- is.data.frame(value)
  is_terra <- inherits(value, "SpatVector") || inherits(value, "SpatRaster")
  is_valid_file <- is.character(value) && file.exists(value)

  if (!(is_tbl_dbi || is_df || is_terra || is_valid_file)) {
    stop('Invalid "value" input passed.')
  }
}

#' Input validation for geomName arg
#' @keywords internal
#' @noRd
.check_geomName <- function(value, geomName) {
  if (is.null(geomName)) {
    stop("geomName cannot be NULL. Please provide a geomName.")
  }

  if (!(geomName %in% colnames(value))) {
    stop("geomName not found in 'value'.")
  }

  .check_name(name = geomName)
}

#' Ensure two dbSpatial objects share the same connection
#' @keywords internal
#' @noRd
.check_con_shared <- function(conn1, conn2) {
  if (!all.equal(conn1, conn2)) {
    stop("conn1 and conn2 must be in the same database connection.")
  }
}

#' Input validation for cols_keep arg in spatial joins
#' @keywords internal
#' @noRd
.check_cols_keep <- function(tbl, cols_keep) {
  if (!identical(cols_keep, "all")) {
    if (!is.character(cols_keep)) {
      stop("cols_keep must be a character or character vector.")
    }

    if (all(cols_keep == "none")) {
      return()
    }

    if (!all(cols_keep %in% colnames(tbl))) {
      stop("cols_keep must be a subset of column names in tbl.")
    }
  }
}
