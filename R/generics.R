## geom_summary ####
#' Get extent of a geometry column in \code{\link{dbSpatial}}  object
#' 
#' @param \code{\link{dbSpatial}}  object
#' @param geomName \code{character string}. The geometry column name in the  \code{\link{dbSpatial}}  object. Default: `"geom"`.
#' @param ... additional arguments passed to methods
#'
#' @return named numeric vector
#' @family geom_summary
#' @export
#'
#' @examples
#' # Create a data.frame with x and y coordinates and attributes
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
#' # Get extent of the table
#' st_extent(db_points)
setGeneric(
  "st_extent",
  function(dbSpatial, geomName = "geom", ...) {
    standardGeneric("st_extent")
  }
)

#' Get maximum x coordinate
#' @name st_xmax
#' @description 
#' This function returns the maximum x coordinate in each `geometry` in 
#' the specified \code{\link{dbSpatial}} object.
#' @param \code{\link{dbSpatial}}  object
#' @param geomName \code{character string}. The geometry column name in the  \code{\link{dbSpatial}}  object. Default: `"geom"`.
#' @param ... additional arguments passed to methods
#' @return numerical column vector in database
#' @family geom_summary
#' @export
#' @examples
#' # Create a data.frame with x and y coordinates and attributes
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
#' st_extent(dbSpatial = db_points)
#'                       
#' st_xmax(dbSpatial = db_points)
setGeneric(
  "st_xmax",
  function(dbSpatial, geomName = "geom", ...) {
    standardGeneric("st_xmax")
  }
)

#' Get maximum y coordinate
#' @name st_ymax
#' @description
#' This function returns the maximum y coordinate of the geometries in the specified \code{\link{dbSpatial}}  object.
#' @param \code{\link{dbSpatial}}  object
#' @param geomName \code{character string}. The geometry column name in the  \code{\link{dbSpatial}}  object. Default: `"geom"`.
#' @param ... additional arguments passed to methods
#' @return numerical column vector in database
#' @family geom_summary
#' @export
#' @examples
#' # Create a data.frame with x and y coordinates and attributes
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
#' st_extent(dbSpatial = db_points)
#'                       
#' st_ymax(dbSpatial = db_points)
setGeneric(
  "st_ymax",
  function(dbSpatial, geomName = "geom", ...) {
    standardGeneric("st_ymax")
  }
)

## spatial_join ####
#' Determine if geometries between two \code{\link{dbSpatial}} objects are intersecting
#' @name st_intersects
#' @description 
#' <https://postgis.net/docs/ST_Intersects.html>
#' @inheritParams .st_spatial_join
#' @param name \code{character}. Default: "intersect_geom"
#' @return \code{\link{dbSpatial}} object
#' @family spatial_join
#' @export
#' @examples
#' con = DBI::dbConnect(duckdb::duckdb(), ":memory:")
#' 
#' coordinates <- data.frame(x = c(100, 200, 300), y = c(500, 600, 700))
#' attributes <- data.frame(id = 1:3, name = c("A1", "B1", "C1"))
#'
#' # Combine the coordinates and attributes
#' dummy_data <- cbind(coordinates, attributes)
#'  
#' points <- dbSpatial(conn = con,
#'                     name = "points", 
#'                     value = dummy_data, 
#'                     overwrite = TRUE, 
#'                     x_colName = "x", 
#'                     y_colName = "y")
#'
#' # preview
#' points
#' 
#' # Create a second set of points, with B1 and C1 translated by + 100
#' dummy_data2 <- dummy_data
#' dummy_data2[c(2,3),c(1,2)] <- dummy_data2[c(2,3),c(1,2)] + 150
#' dummy_data2$name <- c('A2', 'B2', 'C2')
#' 
#' points2 <- dbSpatial(conn = con,
#'                      name = "points2", 
#'                      value = dummy_data2, 
#'                      overwrite = TRUE, 
#'                      x_colName = "x", 
#'                      y_colName = "y")
#' # preview
#' points2
#' 
#' res <- st_intersects(g1 = points, 
#'                      g1_cols_keep = c("name"), 
#'                      g2 = points2,
#'                      overwrite = TRUE)
#' 
#' res
setGeneric(
  "st_intersects",
  function(g1,
           g1_geomName = "geom",
           g1_cols_keep = "all",
           g2,
           g2_geomName = "geom",
           g2_cols_keep = "all",
           overwrite = FALSE,
           name = "intersect_geom",
           ...) {
    standardGeneric("st_intersects")
  }
)

#' Determine if geometries in two \code{\link{dbSpatial}}  objects contain each other
#' @name st_contains
#' @description 
#' <https://postgis.net/docs/ST_Contains.html>
#' @inheritParams .st_spatial_join
#' @param name \code{character}. Default: "contains_geom"
#' @return \code{\link{dbSpatial}} object
#' @family spatial_join
#' @export
#' @examples
#' con = DBI::dbConnect(duckdb::duckdb(), ":memory:")
#' 
#' coordinates <- data.frame(x = c(100, 200, 300), y = c(500, 600, 700))
#' attributes <- data.frame(id = 1:3, name = c("A1", "B1", "C1"))
#'
#' # Combine the coordinates and attributes
#' dummy_data <- cbind(coordinates, attributes)
#'  
#' points <- dbSpatial(conn = con,
#'                     name = "points", 
#'                     value = dummy_data, 
#'                     overwrite = TRUE, 
#'                     x_colName = "x", 
#'                     y_colName = "y")
#'
#' # preview
#' points
#' 
#' # Create a second set of points, with B1 and C1 translated by + 100
#' dummy_data2 <- dummy_data
#' dummy_data2[c(2,3),c(1,2)] <- dummy_data2[c(2,3),c(1,2)] + 150
#' dummy_data2$name <- c('A2', 'B2', 'C2')
#' 
#' points2 <- dbSpatial(conn = con,
#'                      name = "points2", 
#'                      value = dummy_data2, 
#'                      overwrite = TRUE, 
#'                      x_colName = "x", 
#'                      y_colName = "y")
#' # preview
#' points2
#' 
#' res <- st_contains(g1 = points, 
#'                    g1_cols_keep = c("name"), 
#'                    g2 = points2,
#'                    overwrite = TRUE)
#' 
#' res
setGeneric(
  "st_contains",
  function(g1,
           g1_geomName = "geom",
           g1_cols_keep = "all",
           g2,
           g2_geomName = "geom",
           g2_cols_keep = "all",
           overwrite = FALSE,
           name = "contains_geom",
           ...) {
    standardGeneric("st_contains")
  }
)

#' Determine if geometries in two \code{\link{dbSpatial}}  objects are covered by each other
#' @name st_coveredby
#' @description
#' <https://postgis.net/docs/ST_CoveredBy.html>
#' @inheritParams .st_spatial_join
#' @param name \code{character}. Default: "coveredBy_geom"
#' @return \code{\link{dbSpatial}} object
#' @family spatial_join
#' @export
#' @examples
#' con = DBI::dbConnect(duckdb::duckdb(), ":memory:")
#' 
#' coordinates <- data.frame(x = c(100, 200, 300), y = c(500, 600, 700))
#' attributes <- data.frame(id = 1:3, name = c("A1", "B1", "C1"))
#'
#' # Combine the coordinates and attributes
#' dummy_data <- cbind(coordinates, attributes)
#'  
#' points <- dbSpatial(conn = con,
#'                     name = "points", 
#'                     value = dummy_data, 
#'                     overwrite = TRUE, 
#'                     x_colName = "x", 
#'                     y_colName = "y")
#'
#' # preview
#' points
#' 
#' # Create a second set of points, with B1 and C1 translated by + 100
#' dummy_data2 <- dummy_data
#' dummy_data2[c(2,3),c(1,2)] <- dummy_data2[c(2,3),c(1,2)] + 150
#' dummy_data2$name <- c('A2', 'B2', 'C2')
#' 
#' points2 <- dbSpatial(conn = con,
#'                      name = "points2", 
#'                      value = dummy_data2, 
#'                      overwrite = TRUE, 
#'                      x_colName = "x", 
#'                      y_colName = "y")
#' # preview
#' points2
#' 
#' res <- st_coveredby(g1 = points, 
#'                     g1_cols_keep = c("name"), 
#'                     g2 = points2,
#'                     overwrite = TRUE)
#' 
#' res
setGeneric(
  "st_coveredby",
  function(g1,
           g1_geomName = "geom",
           g1_cols_keep = "all",
           g2,
           g2_geomName = "geom",
           g2_cols_keep = "all",
           overwrite = FALSE,
           name = "coveredby_geom",
           ...) {
    standardGeneric("st_coveredby")
  }
)

#' Determine if geometries in two \code{\link{dbSpatial}}  objects cover each other
#' @name st_covers
#' @description
#' https://postgis.net/docs/ST_Covers.html
#' @inheritParams .st_spatial_join
#' @param name \code{character}. Default: "covers_geom"
#' @return \code{\link{dbSpatial}} object
#' @family spatial_join
#' @export
#' @examples
#' con = DBI::dbConnect(duckdb::duckdb(), ":memory:")
#' 
#' coordinates <- data.frame(x = c(100, 200, 300), y = c(500, 600, 700))
#' attributes <- data.frame(id = 1:3, name = c("A1", "B1", "C1"))
#'
#' # Combine the coordinates and attributes
#' dummy_data <- cbind(coordinates, attributes)
#'  
#' points <- dbSpatial(conn = con,
#'                     name = "points", 
#'                     value = dummy_data, 
#'                     overwrite = TRUE, 
#'                     x_colName = "x", 
#'                     y_colName = "y")
#'
#' # preview
#' points
#' 
#' # Create a second set of points, with B1 and C1 translated by + 100
#' dummy_data2 <- dummy_data
#' dummy_data2[c(2,3),c(1,2)] <- dummy_data2[c(2,3),c(1,2)] + 150
#' dummy_data2$name <- c('A2', 'B2', 'C2')
#' 
#' points2 <- dbSpatial(conn = con,
#'                      name = "points2", 
#'                      value = dummy_data2, 
#'                      overwrite = TRUE, 
#'                      x_colName = "x", 
#'                      y_colName = "y")
#' # preview
#' points2
#' 
#' res <- st_covers(g1 = points, 
#'                  g1_cols_keep = c("name"), 
#'                  g2 = points2,
#'                  overwrite = TRUE)
#' 
#' res
setGeneric(
  "st_covers",
  function(g1,
           g1_geomName = "geom",
           g1_cols_keep = "all",
           g2,
           g2_geomName = "geom",
           g2_cols_keep = "all",
           overwrite = FALSE,
           name = "covers_geom",
           ...) {
    standardGeneric("st_covers")
  }
)

#' Determine if geometries in two \code{\link{dbSpatial}}  objects cross each other
#' @name st_crosses
#' @description
#' https://postgis.net/docs/ST_Crosses.html
#' @inheritParams .st_spatial_join
#' @param name \code{character}. Default: "crosses_geom"
#' @return \code{\link{dbSpatial}} object
#' @family spatial_join
#' @export
#' @examples
#' con = DBI::dbConnect(duckdb::duckdb(), ":memory:")
#' 
#' coordinates <- data.frame(x = c(100, 200, 300), y = c(500, 600, 700))
#' attributes <- data.frame(id = 1:3, name = c("A1", "B1", "C1"))
#'
#' # Combine the coordinates and attributes
#' dummy_data <- cbind(coordinates, attributes)
#'  
#' points <- dbSpatial(conn = con,
#'                     name = "points", 
#'                     value = dummy_data, 
#'                     overwrite = TRUE, 
#'                     x_colName = "x", 
#'                     y_colName = "y")
#'
#' # preview
#' points
#' 
#' # Create a second set of points, with B1 and C1 translated by + 100
#' dummy_data2 <- dummy_data
#' dummy_data2[c(2,3),c(1,2)] <- dummy_data2[c(2,3),c(1,2)] + 150
#' dummy_data2$name <- c('A2', 'B2', 'C2')
#' 
#' points2 <- dbSpatial(conn = con,
#'                      name = "points2", 
#'                      value = dummy_data2, 
#'                      overwrite = TRUE, 
#'                      x_colName = "x", 
#'                      y_colName = "y")
#' # preview
#' points2
#' 
#' res <- st_crosses(g1 = points, 
#'                   g1_cols_keep = c("name"), 
#'                   g2 = points2,
#'                   overwrite = TRUE)
#' 
#' res
setGeneric(
  "st_crosses",
  function(g1,
           g1_geomName = "geom",
           g1_cols_keep = "all",
           g2,
           g2_geomName = "geom",
           g2_cols_keep = "all",
           overwrite = FALSE,
           name = "crosses_geom",
           ...) {
    standardGeneric("st_crosses")
  }
)

#' Calculate the difference between geometries in two \code{\link{dbSpatial}}  objects
#' @name st_difference
#' @description
#' https://postgis.net/docs/ST_Difference.html
#' @inheritParams .st_spatial_join
#' @param name \code{character}. Default: "difference_geom"
#' @return \code{\link{dbSpatial}} object
#' @family spatial_join
#' @export
#' @examples
#' con = DBI::dbConnect(duckdb::duckdb(), ":memory:")
#' 
#' coordinates <- data.frame(x = c(100, 200, 300), y = c(500, 600, 700))
#' attributes <- data.frame(id = 1:3, name = c("A1", "B1", "C1"))
#'
#' # Combine the coordinates and attributes
#' dummy_data <- cbind(coordinates, attributes)
#'  
#' points <- dbSpatial(conn = con,
#'                     name = "points", 
#'                     value = dummy_data, 
#'                     overwrite = TRUE, 
#'                     x_colName = "x", 
#'                     y_colName = "y")
#'
#' # preview
#' points
#' 
#' # Create a second set of points, with B1 and C1 translated by + 100
#' dummy_data2 <- dummy_data
#' dummy_data2[c(2,3),c(1,2)] <- dummy_data2[c(2,3),c(1,2)] + 150
#' dummy_data2$name <- c('A2', 'B2', 'C2')
#' 
#' points2 <- dbSpatial(conn = con,
#'                      name = "points2", 
#'                      value = dummy_data2, 
#'                      overwrite = TRUE, 
#'                      x_colName = "x", 
#'                      y_colName = "y")
#' # preview
#' points2
#' 
#' res <- st_difference(g1 = points, 
#'                      g1_cols_keep = c("name"), 
#'                      g2 = points2,
#'                      overwrite = TRUE)
#' 
#' res
setGeneric(
  "st_difference",
  function(g1,
           g1_geomName = "geom",
           g1_cols_keep = "all",
           g2,
           g2_geomName = "geom",
           g2_cols_keep = "all",
           overwrite = FALSE,
           name = "difference_geom",
           ...) {
    standardGeneric("st_difference")
  }
)

#' Determine if geometries in two \code{\link{dbSpatial}}  objects are disjoint
#' @name st_disjoint
#' @description
#' https://postgis.net/docs/ST_Disjoint.html
#' @inheritParams .st_spatial_join
#' @param name \code{character}. Default: "disjoint_geom"
#' @return \code{\link{dbSpatial}} object
#' @family spatial_join
#' @export
#' @examples
#' con = DBI::dbConnect(duckdb::duckdb(), ":memory:")
#' 
#' coordinates <- data.frame(x = c(100, 200, 300), y = c(500, 600, 700))
#' attributes <- data.frame(id = 1:3, name = c("A1", "B1", "C1"))
#'
#' # Combine the coordinates and attributes
#' dummy_data <- cbind(coordinates, attributes)
#'  
#' points <- dbSpatial(conn = con,
#'                     name = "points", 
#'                     value = dummy_data, 
#'                     overwrite = TRUE, 
#'                     x_colName = "x", 
#'                     y_colName = "y")
#'
#' # preview
#' points
#' 
#' # Create a second set of points, with B1 and C1 translated by + 100
#' dummy_data2 <- dummy_data
#' dummy_data2[c(2,3),c(1,2)] <- dummy_data2[c(2,3),c(1,2)] + 150
#' dummy_data2$name <- c('A2', 'B2', 'C2')
#' 
#' points2 <- dbSpatial(conn = con,
#'                      name = "points2", 
#'                      value = dummy_data2, 
#'                      overwrite = TRUE, 
#'                      x_colName = "x", 
#'                      y_colName = "y")
#' # preview
#' points2
#' 
#' res <- st_disjoint(g1 = points, 
#'                    g1_cols_keep = c("name"), 
#'                    g2 = points2,
#'                    overwrite = TRUE)
#' 
#' res
setGeneric(
  "st_disjoint",
  function(g1,
           g1_geomName = "geom",
           g1_cols_keep = "all",
           g2,
           g2_geomName = "geom",
           g2_cols_keep = "all",
           overwrite = FALSE,
           name = "disjoint_geom",
           ...) {
    standardGeneric("st_disjoint")
  }
)

#' Calculate the distance between geometries in two \code{\link{dbSpatial}}  objects
#' @name st_distance
#' @description
#' https://postgis.net/docs/ST_Distance.html
#' @inheritParams .st_spatial_join
#' @param name \code{character}. Default: "distance_geom"
#' @return \code{\link{dbSpatial}} object
#' @family spatial_join
#' @export
#' @examples
#' con = DBI::dbConnect(duckdb::duckdb(), ":memory:")
#' 
#' coordinates <- data.frame(x = c(100, 200, 300), y = c(500, 600, 700))
#' attributes <- data.frame(id = 1:3, name = c("A1", "B1", "C1"))
#'
#' # Combine the coordinates and attributes
#' dummy_data <- cbind(coordinates, attributes)
#'  
#' points <- dbSpatial(conn = con,
#'                     name = "points", 
#'                     value = dummy_data, 
#'                     overwrite = TRUE, 
#'                     x_colName = "x", 
#'                     y_colName = "y")
#'
#' # preview
#' points
#' 
#' # Create a second set of points, with B1 and C1 translated by + 100
#' dummy_data2 <- dummy_data
#' dummy_data2[c(2,3),c(1,2)] <- dummy_data2[c(2,3),c(1,2)] + 150
#' dummy_data2$name <- c('A2', 'B2', 'C2')
#' 
#' points2 <- dbSpatial(conn = con,
#'                      name = "points2", 
#'                      value = dummy_data2, 
#'                      overwrite = TRUE, 
#'                      x_colName = "x", 
#'                      y_colName = "y")
#' # preview
#' points2
#' 
#' res <- st_distance(g1 = points, 
#'                    g1_cols_keep = c("name"), 
#'                    g2 = points2,
#'                    overwrite = TRUE)
#' 
#' res
setGeneric(
  "st_distance",
  function(g1,
           g1_geomName = "geom",
           g1_cols_keep = "all",
           g2,
           g2_geomName = "geom",
           g2_cols_keep = "all",
           overwrite = FALSE,
           name = "distance_geom",
           ...) {
    standardGeneric("st_distance")
  }
)

#' Determine if geometries in two \code{\link{dbSpatial}}  objects are equal
#' @name st_equals
#' @description
#' https://postgis.net/docs/ST_Equals.html
#' @inheritParams .st_spatial_join
#' @param name \code{character}. Default: "equals_geom"
#' @return \code{\link{dbSpatial}} object
#' @family spatial_join
#' @export
#' @examples
#' con = DBI::dbConnect(duckdb::duckdb(), ":memory:")
#' 
#' coordinates <- data.frame(x = c(100, 200, 300), y = c(500, 600, 700))
#' attributes <- data.frame(id = 1:3, name = c("A1", "B1", "C1"))
#'
#' # Combine the coordinates and attributes
#' dummy_data <- cbind(coordinates, attributes)
#'  
#' points <- dbSpatial(conn = con,
#'                     name = "points", 
#'                     value = dummy_data, 
#'                     overwrite = TRUE, 
#'                     x_colName = "x", 
#'                     y_colName = "y")
#'
#' # preview
#' points
#' 
#' # Create a second set of points, with B1 and C1 translated by + 100
#' dummy_data2 <- dummy_data
#' dummy_data2[c(2,3),c(1,2)] <- dummy_data2[c(2,3),c(1,2)] + 150
#' dummy_data2$name <- c('A2', 'B2', 'C2')
#' 
#' points2 <- dbSpatial(conn = con,
#'                      name = "points2", 
#'                      value = dummy_data2, 
#'                      overwrite = TRUE, 
#'                      x_colName = "x", 
#'                      y_colName = "y")
#' # preview
#' points2
#' 
#' res <- st_equals(g1 = points, 
#'                  g1_cols_keep = c("name"), 
#'                  g2 = points2,
#'                  overwrite = TRUE)
#' 
#' res
setGeneric(
  "st_equals",
  function(g1,
           g1_geomName = "geom",
           g1_cols_keep = "all",
           g2,
           g2_geomName = "geom",
           g2_cols_keep = "all",
           overwrite = FALSE,
           name = "equals_geom",
           ...) {
    standardGeneric("st_equals")
  }
)

#' Determine if geometries in two \code{\link{dbSpatial}}  objects touch each other
#' @name st_touches
#' @description
#' https://postgis.net/docs/ST_Touches.html
#' @inheritParams .st_spatial_join
#' @param name \code{character}. Default: "touches_geom"
#' @return \code{\link{dbSpatial}} object
#' @family spatial_join
#' @export
#' @examples
#' con = DBI::dbConnect(duckdb::duckdb(), ":memory:")
#' 
#' coordinates <- data.frame(x = c(100, 200, 300), y = c(500, 600, 700))
#' attributes <- data.frame(id = 1:3, name = c("A1", "B1", "C1"))
#'
#' # Combine the coordinates and attributes
#' dummy_data <- cbind(coordinates, attributes)
#'  
#' points <- dbSpatial(conn = con,
#'                     name = "points", 
#'                     value = dummy_data, 
#'                     overwrite = TRUE, 
#'                     x_colName = "x", 
#'                     y_colName = "y")
#'
#' # preview
#' points
#' 
#' # Create a second set of points, with B1 and C1 translated by + 100
#' dummy_data2 <- dummy_data
#' dummy_data2[c(2,3),c(1,2)] <- dummy_data2[c(2,3),c(1,2)] + 150
#' dummy_data2$name <- c('A2', 'B2', 'C2')
#' 
#' points2 <- dbSpatial(conn = con,
#'                      name = "points2", 
#'                      value = dummy_data2, 
#'                      overwrite = TRUE, 
#'                      x_colName = "x", 
#'                      y_colName = "y")
#' # preview
#' points2
#' 
#' res <- st_touches(g1 = points, 
#'                   g1_cols_keep = c("name"), 
#'                   g2 = points2,
#'                   overwrite = TRUE)
#' 
#' res
setGeneric(
  "st_touches",
  function(g1,
           g1_geomName = "geom",
           g1_cols_keep = "all",
           g2,
           g2_geomName = "geom",
           g2_cols_keep = "all",
           overwrite = FALSE,
           name = "touches_geom",
           ...) {
    standardGeneric("st_touches")
  }
)

## geom_scalar ####
#' Return geometry type
#' @name st_geometrytype
#' @description 
#' This function returns the geometry type of the specified geometry column in 
#' a \code{\link{dbSpatial}}  object.
#' @param \code{\link{dbSpatial}}  object
#' @param geomName \code{character string}. The geometry column name in the  \code{\link{dbSpatial}}  object. Default: `"geom"`.
#' @param ... additional arguments passed to methods
#' @return factor column vector in database
#' @family geom_scalar
#' @export
#' @examples
#' # Create a data.frame with x and y coordinates and attributes
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
#' st_geometrytype(dbSpatial = db_points)
setGeneric(
  "st_geometrytype",
  function(dbSpatial, geomName = "geom", ...) {
    standardGeneric("st_geometrytype")
  }
)

#' Determine if geometry is valid
#' @name st_isvalid
#' @description 
#' This function returns whether the specified geometry column in the specified
#' \code{\link{dbSpatial}}  object is valid or not. 
#' @param \code{\link{dbSpatial}}  object
#' @param geomName \code{character string}. The geometry column name in the  \code{\link{dbSpatial}}  object. Default: `"geom"`.
#' @param ... additional arguments passed to methods
#' @return boolean column vector in database
#' @family geom_scalar
#' @export
#' @examples
#' # Create a data.frame with x and y coordinates and attributes
#' coordinates <- data.frame(x = c(100, 200, 300), y = c(500, 600, 700))
#' attributes <- data.frame(id = 1:3, name = c("A", "B", "C"))
#'
#' # Combine the coordinates and attributes
#' dummy_data <- cbind(coordinates, attributes)
#'
#' # Create a SpatVector from the data.frame
#' dummy_spatvector <- terra::vect(dummy_data, geom = c("x", "y"))
#'
#' # Create a duckdb connection
#' duckdb_conn = DBI::dbConnect(duckdb::duckdb(), ":memory:")
#'
#' # Create a duckdb table with spatial points
#' db_points = dbSpatial(conn = duckdb_conn,
#'                       name = "spatVector_proxy",
#'                       value = dummy_spatvector,
#'                       overwrite = TRUE)
#'
#' # Check if geometries are valid
#' st_isvalid(dbSpatial = db_points)
setGeneric(
  "st_isvalid",
  function(dbSpatial, geomName = "geom", ...) {
    standardGeneric("st_isvalid")
  }
)

## geom_construction ####
#' Translate x, y coordinates by delta x, delta y for point geometries
#' @name st_translate
#' @description
#' This function translates point geometries by the specified delta x and delta y values.
#' @param \code{\link{dbSpatial}}  object
#' @param geomName \code{character string}. The geometry column name in the  \code{\link{dbSpatial}}  object. Default: `"geom"`.
#' @param dx \code{numeric}.value to shift x coordinates by
#' @param dy \code{numeric}. value to shift y coordinates by
#' @param name \code{string.} name of table to add to \code{\link{dbSpatial}} object.
#' @param ... additional arguments passed to methods
#' @return \code{\link{dbSpatial}} object
#' @family geom_construction
#' @export
#' @examples
#' con = DBI::dbConnect(duckdb::duckdb(), ":memory:")
#' 
#' coordinates <- data.frame(x = c(100, 200, 300), y = c(500, 600, 700))
#' attributes <- data.frame(id = 1:3, name = c("A", "B", "C"))
#'
#' # Combine the coordinates and attributes
#' dummy_data <- cbind(coordinates, attributes)
#'  
#' points <- dbSpatial(conn = con,
#'                     name = "points", 
#'                     value = dummy_data, 
#'                     overwrite = TRUE, 
#'                     x_colName = "x", 
#'                     y_colName = "y")
#' 
#' points
#' 
#' points_translated <- st_translate(dbSpatial = points, dx = 100, dy = -20)
#' 
#' points_translated
setGeneric(
  "st_translate",
  function(dbSpatial, geomName = "geom", dx, dy, ...) {
    standardGeneric("st_translate")
  }
)

#' @title Tessellate a \code{\link{dbSpatial}}  object
#' @name tessellate
#' @description
#' Creates a tessellation on the extent of \code{\link{dbSpatial}}  with specified parameters.
#' @param \code{\link{dbSpatial}}  object
#' @param name \code{character string} name of table to add to \code{\link{dbSpatial}} object. Default: "tessellation".
#' @param geomName \code{character string}. The geometry column name in the  \code{\link{dbSpatial}}  object. Default: `"geom"`.
#' @param shape \code{character string}. A character string indicating the shape of the tessellation. 
#'   Options are "hexagon" or "square".
#' @param shape_size \code{numeric}. the size of the shape in the tessellation.
#'   If `NULL`, a default size is calculated. See `GiottoClass::tessellate` for details.
#' @param gap \code{numeric}. Value indicating the gap between tessellation shapes. Defaults to 0.
#' @param radius \code{numeric}. Value specifying the radius for hexagonal tessellation. 
#'   This parameter is ignored for square tessellations.
#' @param overwrite \code{logical}. Boolean value indicating whether to overwrite an 
#' existing tessellation with the same name. Default: `FALSE`.
#' @param ... Additional arguments passed to methods.
#'
#' @return \code{\link{dbSpatial}} object
#' @family geom_construction
#' @export
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
setGeneric("tessellate", 
           function(dbSpatial,
                    geomName = "geom",
                    name = "tessellation",
                    shape = c("hexagon", "square"),
                    shape_size = NULL,
                    gap = 0,
                    radius = NULL,
                    overwrite = FALSE, 
                    ...) {
  standardGeneric("tessellate")
})