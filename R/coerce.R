# Coerce dbSpatial to SpatVector
setAs("dbSpatial", "SpatVector", function(from) {
  .check_mem_limit(from)
  vect(from)
})

# Coerce dbSpatial to sf
setAs("dbSpatial", "sf", function(from) {
  .check_mem_limit(from)
  sf::st_as_sf(from)
})


#' @keywords internal
#' @noRd
.check_mem_limit <- function(x) {
  limit <- getOption("dbSpatial.max_mem_convert", default = 8 * 1024^3)

  n_rows <- x[] |> dplyr::count() |> dplyr::pull(n) |> as.numeric()
  est_size <- n_rows * 1024 # ~1KB per row estimate

  if (est_size > limit) {
    stop(
      sprintf(
        paste0(
          "dbSpatial: Coercion blocked (est: %s, limit: %s).\n",
          "Increase 'dbSpatial.max_mem_convert' to override."
        ),
        format(est_size, units = "auto", standard = "SI"),
        format(limit, units = "auto", standard = "SI")
      ),
      call. = FALSE
    )
  }

  if (getOption("dbSpatial.verbose", default = TRUE)) {
    cli::cli_alert_info(
      "Coercing dbSpatial to in-memory (est: {format(est_size, units = 'auto', standard = 'SI')})"
    )
  }
}
