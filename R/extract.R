# dbData ####
## Empty ####
### Extract [] ####
#' @title Extract method for dbSpatial
#' @name dbData
#' @rdname hidden_aliases
#' @family dbData
#' @export
setMethod('[', 
          signature(x = 'dbSpatial', i = 'missing', j = 'missing', drop = 'missing'),
          function(x, i, j, ...) {
          methods::slot(x, "value")
          })

### Set [] ####
# no initialize to prevent slowdown
#' @title Set method for dbSpatial
#' @name dbData
#' @rdname hidden_aliases
#' @family dbData
#' @export
setMethod('[<-',
          signature(
            x = 'dbSpatial',
            value = 'ANY'
          ),
          function(x, value) {
            methods::slot(x, "value") <- value
            x
          })

# head ####
#' @title head method for dbSpatial
#' @name head
#' @family dbData
#' @export
setMethod('head',
          signature(x = 'dbSpatial'), 
          function(x, n = 6L, ...) {
            x[] <- x[] |> head(n)
            
            return(x)
          })


# tail ####
#' @title tail method for dbSpatial
#' @name tail
#' @family dbData
#' @export
setMethod('tail',
          signature(x = 'dbSpatial'), 
          function(x, n = 6L, ...) {
            x[] <- x[] |> tail(n)
            
            return(x)
          })