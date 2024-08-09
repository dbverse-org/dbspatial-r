#' @keywords internal
.tessellate <- function(dbSpatial,
                        geomName = "geom",
                        name = "tessellation",
                        shape = c("hexagon", "square"),
                        shape_size = NULL,
                        gap = 0,
                        radius = NULL,
                        overwrite = FALSE,
                        ...) {
  tbl <- dbSpatial[]
  con <- dbplyr::remote_con(tbl)
  .check_con(conn = con)
  .check_name(name = name)
  .check_tbl(tbl = tbl)
  .check_geomName(value = tbl, geomName = geomName)
  .check_overwrite(conn = con, overwrite = overwrite, name = name)

  if (!shape %in% c("hexagon", "square")) {
    stop("shape must be either 'hexagon' or 'square'")
  }
  
  # ensure shape_size, gap and radius are numerical values
  if (!is.null(shape_size)) {
    if (!is.numeric(shape_size)) {
      stop("shape_size must be a numerical value")
    }
  }
  if (!is.null(gap)) {
    if (!is.numeric(gap)) {
      stop("gap must be a numerical value")
    }
  }
  if (!is.null(radius)) {
    if (!is.numeric(radius)) {
      stop("radius must be a numerical value")
    }
  }
  
  # in-memory processing -------------------------------------------------------
  
  # dbSpatial parameters
  ext = st_extent(dbSpatial, geomName = geomName)
  
  # retrieve tessellations
  gpolys <- GiottoClass::tessellate(extent = ext, shape = shape, shape_size)
  sv <- methods::slot(gpolys, 'spatVector')
  
  # convert terra geoms to wkt polygons via sf
  # TODO: implement sf::st_make_grid to avoid this step
  res <- gpolys[] |>
    as_dbSpatial(conn = con, overwrite = overwrite, name = name)
  
   # Note: Cannot compute with the same name if it's an arrow table in the db
   # DBI::dbExistsTable(con, name) wil show true but
   # DBI::dbListTables(con, name) will show false;
   # see .check_overwrite() for catching arrow tables
   # res <- res |> dplyr::compute(name = name, overwrite = TRUE)
  
  return(res)
}

#' @describeIn tessellate Method for `dbSpatial` object
setMethod(
  "tessellate",
  signature(dbSpatial = "dbSpatial"),
  function(dbSpatial, ...) .tessellate(dbSpatial, ...)
)