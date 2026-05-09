#' @include st_spatial_join.R
NULL

#' Spatial join for dbSpatial objects
#'
#' @description
#' Performs a spatial join between two dbSpatial objects using a specified
#' spatial predicate function.
#'
#' @param x A \code{\link{dbSpatial}} object.
#' @param y A \code{\link{dbSpatial}} object.
#' @param join Spatial predicate function to use for the join. Default is
#'   \code{st_intersects}. Supported predicates: \code{st_intersects},
#'   \code{st_contains}, \code{st_within}, \code{st_covers}, \code{st_covered_by},
#'   \code{st_crosses}, \code{st_disjoint}, \code{st_equals}, \code{st_touches},
#'   \code{st_overlaps}.
#' @param suffix Character vector of length 2. Suffixes to add to duplicate
#'   column names from x and y. Default is \code{c(".x", ".y")}.
#' @param ... Additional arguments passed to the internal join function.
#'
#' @return A \code{\link{dbSpatial}} object containing the spatial join result.
#'
#' @details
#' This function follows the \code{sf} pattern where spatial predicates are passed
#' as the \code{join} argument.
#'
#' @examples
#' if (requireNamespace("duckdb", quietly = TRUE)) {
#'   con <- DBI::dbConnect(duckdb::duckdb(), ":memory:")
#'
#'   df1 <- data.frame(id = 1:3, x = c(0, 10, 20), y = c(0, 10, 20))
#'   pts1 <- dbSpatial(conn = con, name = "pts1", value = df1,
#'                     x_colName = "x", y_colName = "y", overwrite = TRUE)
#'
#'   df2 <- data.frame(id = 4:6, x = c(0, 15, 25), y = c(0, 15, 25))
#'   pts2 <- dbSpatial(conn = con, name = "pts2", value = df2,
#'                     x_colName = "x", y_colName = "y", overwrite = TRUE)
#'
#'   # Spatial join using intersection
#'   result <- sf::st_join(pts1, pts2, join = sf::st_intersects)
#'
#'   # Spatial join using within predicate
#'   result <- sf::st_join(pts1, pts2, join = sf::st_within)
#'
#'   DBI::dbDisconnect(con, shutdown = TRUE)
#' }
#'
#' @export
#' @method st_join dbSpatial
st_join.dbSpatial <- function(x, y, join = st_intersects,
                               suffix = c(".x", ".y"), ...) {
  # sf predicate name -> DuckDB SQL predicate
  sql_predicates <- c(
    st_intersects = "ST_Intersects",
    st_contains = "ST_Contains",
    st_within = "ST_Within",
    st_covers = "ST_Covers",
    st_covered_by = "ST_CoveredBy",
    st_crosses = "ST_Crosses",
    st_disjoint = "ST_Disjoint",
    st_equals = "ST_Equals",
    st_touches = "ST_Touches",
    st_overlaps = "ST_Overlaps",
    st_is_within_distance = "ST_DWithin"
  )

  join_name <- deparse(substitute(join))
  join_name <- sub("^sf::", "", join_name)
  st_predicate <- sql_predicates[[join_name]]

  if (is.null(st_predicate) || is.na(st_predicate)) {
    stop(
      "Unsupported join predicate: ", join_name, ". ",
      "Supported: ", paste(names(sql_predicates), collapse = ", "), ".",
      call. = FALSE
    )
  }

  # Generate output table name based on predicate
  out_name <- paste0(tolower(sub("^ST_", "", st_predicate)), "_result")
  vals <- c(letters, LETTERS, 0:9)
  suffix <- paste0(sample(vals, 10, replace = TRUE), collapse = "")
  out_name <- paste0(out_name, "_", suffix)

  # Call internal spatial join
  .st_spatial_join(
    g1 = x,
    g2 = y,
    st_name = st_predicate,
    name = out_name,
    ...
  )
}
