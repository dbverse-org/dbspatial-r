# dbData ####
## Empty ####
### Extract [] ####
# Inherit from dbData class in {dbProject}

### Set [] ####
# Inherit from dbData class in {dbProject}

# head ####
#' @title head method for dbSpatial
#' @name head
#' @family dbData
#' @export
setMethod('head', signature(x = 'dbSpatial'), function(x, n = 6L, ...) {
  x[] <- x[] |> head(n)

  return(x)
})


# tail ####
#' @title tail method for dbSpatial
#' @name tail
#' @family dbData
#' @export
setMethod('tail', signature(x = 'dbSpatial'), function(x, n = 6L, ...) {
  x[] <- x[] |> tail(n)

  return(x)
})
