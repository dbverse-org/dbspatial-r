#' @importFrom sf st_as_sf st_read
#' @importFrom dbplyr sql_render remote_con
#' @importFrom tidyselect everything all_of
NULL

#' Convert dbSpatial objects to sf objects
#'
#' @description
#' S3 method implementation for converting `dbSpatial` objects to `sf` objects.
#'
#' @param x A [`dbSpatial`] object to convert
#' @param geomName \code{character string}. The geometry column name in the  
#' [`dbSpatial`] object. Default: `"geom"`.
#' @param select Columns to retain in output (default: all columns)
#' @param ... Additional arguments passed to [`sf::st_read`]
#'
#' @return An [`sf`] object
#'
#' @details
#' This method handles conversion of [`dbSpatial`] to [`sf`] objects using:
#' - Dynamic column selection via tidyselect semantics
#' - Automatic geometry column preservation
#' - SQL-level column subsetting for efficiency
#'
#' @family dbSpatial
#' @method st_as_sf dbSpatial
#' @export
st_as_sf.dbSpatial <- function(x, geomName = "geom", select = tidyselect::everything(), ...) {
  .st_as_sf(x, geomName = geomName, select = {{ select }}, ...)
}

#' @keywords internal
.st_as_sf <- function(x, geomName = "geom", select, ...) {
  con <- dbplyr::remote_con(x[])
  .check_con(con)
  .check_geomName(value = x[], geomName = geomName)
  
  # Process column selection with tidy evaluation
  sql <- x[] |> 
    dplyr::select({{select}}, tidyselect::all_of(geomName)) |> 
    dplyr::mutate(!!geomName := ST_AsWKB(!!rlang::sym(geomName))) |>
    dbplyr::sql_render()
  
  res <- sf::st_read(
    dsn = con,
    query = sql,
    geometry_column = geomName,
    ...
  )
  
  return(res)
}
