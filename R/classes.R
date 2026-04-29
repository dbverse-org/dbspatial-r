## S4 Class Specification ####
# Note: dbData class is imported from dbProject package - no need to redefine it here
#' @importClassesFrom dbProject dbData

#' @exportClass dbSpatial
dbSpatial = setClass(
  Class = 'dbSpatial',
  contains = c('dbData')
)
