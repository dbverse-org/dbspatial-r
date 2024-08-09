#' @title Convert an {sf} or {terra} object to a `dbSpatial` object
#' @description
#' Create a \code{\link{dbSpatial}} object from an \code{sf} or \code{terra} object.
#' 
#' @details
#' Writes out the `rSpatial` object to temporary .parquet file and
#' computes the VIEW in the database with the specified `name` and the geometry
#' column as `geom`.
#' 
#' @param rSpatial \code{sf} or \code{terra} object.
#' @param conn A \code{\link{DBIConnection}} object, as returned by \code{\link{DBI::dbConnect}}.
#' @param name \code{a character string} with the unquoted DBMS table name, e.g. "table_name"
#' @param overwrite \code{logical}. Overwrite existing table. default = FALSE.
#' @param ... Additional arguments to be passed
#' @family dbSpatial
#' @export
#' @examples
#' coordinates <- data.frame(x = c(100, 200, 300), y = c(500, 600, 700))
#' attributes <- data.frame(id = 1:3, name = c("A", "B", "C"))
#' 
#' # Combine the coordinates and attributes
#' dummy_data <- cbind(coordinates, attributes)
#' 
#' # Create a SpatVector from the data.frame
#' dummy_spatvector <- terra::vect(dummy_data, geom = c("x", "y"))
#'
#' # Set db connection
#' duckdb_conn = DBI::dbConnect(duckdb::duckdb(), ":memory:")
#' 
#' dbSpatial <- as_dbSpatial(rSpatial = dummy_spatvector,
#'                          conn = duckdb_conn,
#'                          name = "dummy_spatvector",
#'                          overwrite = TRUE)
#' dbSpatial
as_dbSpatial <- function(rSpatial,
                         conn,
                         name,
                         overwrite = FALSE,
                         ...) {
  # input validation
  .check_con(conn = conn)
  .check_name(name = name)
  .check_overwrite(conn = conn, name = name, overwrite = overwrite)
  
  # Load spatial extension
  suppressMessages(loadSpatial(conn = conn))
  
  
  # check that rSpatial is of class sf or terra
  if(!(inherits(rSpatial, "sf") || inherits(rSpatial, "SpatVector"))){
    stop("rSpatial must be an {sf} or {terra} object.")
  }
  
  if(inherits(rSpatial, "SpatRaster")) {
    stop("Support for {terra} SpatRaster objects not yet implemented.")
  }
  
  temp_file <- tempfile(tmpdir = getwd(), fileext = ".parquet")
  
  to_parquet <- function(rSpatial){
      suppressWarnings(sfarrow::write_sf_dataset(obj = rSpatial, path = temp_file))
  }
  
  if (inherits(rSpatial, "sf")) {
    to_parquet(rSpatial)
  } else if(inherits(rSpatial, "SpatVector") || inherits(rSpatial, "SpatRaster")) {
    rSpatial |>
      sf::st_as_sf() |> # workaround for lack of arrow support in terra v1.7.78
      to_parquet()
  }
  
  tbl <- arrow::open_dataset(temp_file) |> 
    arrow::to_duckdb(con = conn) |>
    dplyr::mutate(geom = st_geomfromwkb(geometry)) |>
    dplyr::compute(overwrite = overwrite, name = name)
  
  res <- dbSpatial(value = tbl, name = name)
  
  unlink(temp_file, recursive = TRUE, force = TRUE) # delete temp file
  
  return(res)
  
}