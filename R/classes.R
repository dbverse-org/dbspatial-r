## S4 Class Specification ####
# Note: dbData class is imported from dbProject package - no need to redefine it here
#' @importClassesFrom dbProject dbData

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
  contains = c('dbData')
)
