# Package imports ----
# This file contains @importFrom directives for external package functions
# used throughout the dbSpatial package.

# dbProject ----
#' @importFrom dbProject .check_con .check_name .check_overwrite .check_tbl
NULL

# sf spatial predicates ----
# These are imported for use with st_join()
# Users should use st_join(x, y, join = st_intersects) instead of calling
# predicates directly. Direct predicate calls are not supported for dbSpatial.
#' @importFrom sf st_intersects st_contains st_covered_by st_covers
#' @importFrom sf st_crosses st_disjoint st_equals st_touches
#' @importFrom sf st_within st_overlaps st_is_within_distance
NULL

# sf join generic ----
# Needed so the sf S3 generic exists when registering st_join.dbSpatial.
#' @importFrom sf st_join
NULL

# sf generics (for S3 registration) ----
# These imports ensure the sf S3 generics exist at namespace load time, so the
# S3 methods implemented in this package can be registered.
#' @importFrom sf st_geometry_type st_is_valid
NULL

# sf geometry functions ----

