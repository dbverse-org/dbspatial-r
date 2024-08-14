## S4 Class Specification ####
#' @name dbData
#' @title dbData
#' @description Base class for all db objects
#' @noRd
setClass(
  Class = 'dbData',
  contains = c('VIRTUAL')
)

#' @title S4 dbSpatial class
#' @description
#' Representation of spatial geometries in a database. Each object
#' is used as a connection to a single table that exists within a DuckDB database.
#' @slot conn \code{\link{duckdb_connection}}. A connection object to a DuckDB database.
#' @slot name \code{character}. Name of table in the database.
#' @slot value value representing the table in the database.
#' @noRd
#' @export
dbSpatial = setClass(
  Class = 'dbSpatial',
  contains = c('dbData'),
  slots = list(
    conn = 'duckdb_connection',
    name = 'character',
    value = "ANY"
    ),
  prototype = list(
    conn = NULL,
    name = NA_character_,
    value = NULL
  )
)