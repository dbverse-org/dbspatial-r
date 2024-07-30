#' Tessellate a dbSpatial object
#'
#' Creates a tessellation on the extent of `dbSpatial` with specified parameters.
#' The tessellation can be composed of hexagons or squares.
#'
#' @param dbSpatial A `dbSpatial` object representing the spatial table.
#' @param name A character string specifying the name of the tessellation.
#' @param geomName A character string specifying the name of the geometry column in the database.
#' @param shape A character string indicating the shape of the tessellation. 
#'   Options are "hexagon" or "square".
#' @param shape_size A numeric value specifying the size of the shapes in the tessellation.
#'   If `NULL`, a default size is calculated. See `GiottoClass::tessellate` for details.
#' @param gap A numeric value indicating the gap between tessellation shapes. Defaults to 0.
#' @param index A logical value indicating whether to create an index on each geometry.Default: 'FALSE'
#' @param radius A numeric value specifying the radius for hexagonal tessellation. 
#'   This parameter is ignored for square tessellations.
#' @param overwrite A logical value indicating whether to overwrite an 
#' existing tessellation with the same name. Default: `FALSE`.
#' @param ... Additional arguments passed to underlying tessellation functions.
#'
#' @return The function writes the tessellation to the database connected to `dbSpatial` and 
#'   returns invisibly.
#' @family geom_construction
#' @examples
#' coordinates <- data.frame(x = c(100, 200, 300), y = c(500, 600, 700))
#' attributes <- data.frame(id = 1:3, name = c("A", "B", "C"))
#'
#' # Combine the coordinates and attributes
#' dummy_data <- cbind(coordinates, attributes)
#' 
#' # Create a duckdb connection
#' con = DBI::dbConnect(duckdb::duckdb(), ":memory:")
#'
#' # Create a duckdb table with spatial points
#' db_points = dbSpatial(conn = con,
#'                       value = dummy_data,
#'                       x_colName = "x",
#'                       y_colName = "y",
#'                       name = "foo",
#'                       overwrite = TRUE)
#'                       
#' tessellate(db_points, name = "my_tessellation", shape = "hexagon", shape_size = 60)
#'
#' @export
tessellate <- function(dbSpatial,
                       geomName = "geom",
                       name = "tessellation",
                       shape = c("hexagon", "square"),
                       shape_size = NULL,
                       gap = 0,
                       index = FALSE,
                       radius = NULL,
                       overwrite = FALSE,
                       ...) {
  # input validation
  # if (!inherits(dbSpatial, "dbSpatial")) {
  #   stop("dbSpatial must be a dbSpatial object")
  # }
  
  .check_name(name)

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
  con = dbplyr::remote_con(dbSpatial)
  
  # retrieve tessellations
  gpolys <- GiottoClass::tessellate(extent = ext, shape = shape, shape_size)
  
  # convert terra geoms to wkt polygons via sf
  # TODO: implement sf::st_make_grid to avoid this step
  wkt_polys <- gpolys[] |>
    sf::st_as_sf() |>
    sf::st_geometry() |>
    sf::st_as_text() |>
    dplyr::as_tibble()
  
  # write to database ----------------------------------------------------------
  res <- dplyr::copy_to(
    dest = con,
    df = wkt_polys,
    temporary = TRUE,
    overwrite = overwrite
  ) |>
    dplyr::mutate(geom = st_geomfromtext(value)) |>
    # drop the value column
    dplyr::select(-value)
  
  if(index){
    res <- res |> dplyr::mutate(index = dplyr::row_number())
  }
  
   res <- res |> dplyr::compute(name = name, overwrite = TRUE)
  
  return(res)
}
