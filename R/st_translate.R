#' @keywords internal
.st_translate <- function(dbSpatial, geomName = "geom", dx, dy, ...) {
  if (missing(dx) || missing(dy)) stop("Please provide dx and dy")
  if (!is.numeric(dx) || !is.numeric(dy)) stop("dx and dy must be numeric")

  # Pass dx and dy explicitly as a named list.
  # We also provide param_names to ensure correct ordering if we ever changed the list construction.
  .st_mutate_geom(
    dbSpatial, 
    st_func = "ST_Translate", 
    geomName = geomName, 
    dest_col = NULL, 
    args = list(dx = dx, dy = dy),
    param_names = c("dx", "dy")
  )
}

#' @describeIn st_translate Method for `dbSpatial` object
setMethod(
  "st_translate",
  signature(dbSpatial = "dbSpatial"),
  function(dbSpatial, geomName = "geom", dx, dy, ...) {
    .st_translate(dbSpatial = dbSpatial, geomName = geomName, dx = dx, dy = dy)
  }
)
