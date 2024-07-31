#' @param rSpatial \code{sf} or \code{terra} object.
#' @param conn \code{\link{duckdb_connection}}. A connection object to a DuckDB database.
#' @param name \code{character}. Name of table to add to the database.
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
#' dbSpatial <- to_dbSpatial(rSpatial = dummy_spatvector,
#'                          conn = duckdb_conn,
#'                          name = "dummy_spatvector",
#'                          overwrite = TRUE)
to_dbSpatial <- function(rSpatial,
                         conn,
                         name,
                         overwrite = FALSE,
                         ...) {
  # input validation
  .check_con(conn = conn)
  .check_name(name = name)
  .check_overwrite(conn = con, name = name, overwrite = overwrite)
  
  
  # check that rSpatial is of class sf or terra
  if(!(inherits(rSpatial, "sf") || inherits(rSpatial, "SpatVector") || 
       inherits(rSpatial, "SpatRaster"))){
    stop("rSpatial must be an {sf} or {terra} object.")
  }
  
  temp_file <- tempfile(tmpdir = getwd(), fileext = ".parquet")
  
  to_parquet <- function(rSpatial){
      suppressWarnings(sfarrow::write_sf_dataset(obj = rSpatial, path = temp_file))
  }
  
  if (inherits(rSpatial, "sf")) {
    # convert to terra
    to_parquet(rSpatial)
  } else if(inherits(rSpatial, "SpatVector") || inherits(rSpatial, "SpatRaster")) {
    rSpatial |>
      sf::st_as_sf() |> # workaround for lack of arrow support in terra v1.7.78
      to_parquet()
  }
  
  tbl <- arrow::open_dataset(temp_file) |> 
    arrow::to_duckdb(con = con) |>
    dplyr::mutate(geom = st_geomfromwkb(geometry)) |>
    dplyr::select(-geometry) |>
    dplyr::compute(name = name, overwrite = TRUE)
  
  res <- dbSpatial(
    conn = conn,
    name = name,
    value = tbl,
    geomName = 'geometry',
    overwrite = FALSE
  )
  
  unlink(temp_file) # delete temp file
  
  return(res)
  
}