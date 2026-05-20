# dbData ####
## Empty ####
### Extract [] ####
# Inherit from dbData class in {dbProject}

### Set [] ####
# Inherit from dbData class in {dbProject}

# head ####
#' @title head method for dbSpatial
#' @param x A `dbSpatial` object.
#' @param n Number of rows to return.
#' @param ... Additional arguments.
#' @return A `dbSpatial` object containing the first `n` rows of `x`.
#' @rdname head
#' @aliases head,dbSpatial-method
#' @family dbData
#' @export
setMethod('head', signature(x = 'dbSpatial'), function(x, n = 6L, ...) {
  x[] <- x[] |> head(n)

  return(x)
})


# tail ####
#' @title tail method for dbSpatial
#' @param x A `dbSpatial` object.
#' @param n Number of rows to return.
#' @param ... Additional arguments.
#' @return A `dbSpatial` object containing the last `n` rows of `x`.
#' @rdname tail
#' @aliases tail,dbSpatial-method
#' @family dbData
#' @export
setMethod('tail', signature(x = 'dbSpatial'), function(x, n = 6L, ...) {
  x[] <- x[] |> tail(n)

  return(x)
})


# $ ####
#' @title Column extraction for dbSpatial
#' @name $,dbSpatial-method
#' @description Extract a column from a dbSpatial object
#' @param x A dbSpatial object
#' @param name Column name to extract
#' @returns A vector of values from the specified column
#' @export
setMethod('$', signature(x = 'dbSpatial'), function(x, name) {
  x[] |>
    dplyr::select(dplyr::all_of(name)) |>
    dplyr::collect() |>
    dplyr::pull(name)
})
