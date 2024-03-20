#' Input validation for conn arg
#' @keywords internal
#' @noRd
.check_con <- function(conn){
  if(missing(conn)) {
    stop("Please provide a connection")
  }
  
  if(!DBI::dbIsValid(conn)) {
    stop("Stale connection. Reconnect your db connection.")
  }
  
  if(!inherits(conn, "duckdb_connection")) {
    stop("conn must be a duckdb connection. Use duckdb drv in DBI::dbConnect()")
  }
}


#' Input validation for data arg
#' @keywords internal
#' @noRd
.check_value <- function(value){
  is_tbl_dbi = inherits(value, "tbl_dbi")
  is_df = is.data.frame(value)
  is_terra = inherits(value, "SpatVector") | inherits(value, "SpatRaster")
  if(is.character(value)){
    is_valid_file = file.exists(value)
  } else {
    is_valid_file = FALSE
  }
  
  if(!(is_tbl_dbi | is_df | is_terra | is_valid_file)) {
    stop(
      'Invalid "value" input passed.'
    )
  }
}

#' Input validation for tbl arg
#' @keywords internal
#' @noRd
.check_tbl <- function(tbl){
  if (missing(tbl)) {
    stop("Please provide a table name")
  }
  
  # check that tbl is from a duckdb connection
  if (!inherits(tbl, "tbl_duckdb_connection")) {
    stop("Please provide a duckdb table")
  }
}

#' Input validation for name arg
#' @keywords internal
#' @noRd
.check_name <- function(name){
  if(missing(name)) {
    stop("Please provide a table name")
  }
  
  if(is.null(name)) {
    stop("name cannot be NULL. Did you forget to dplyr::compute()?")
  }
  
  if(!is.character(name)) {
    stop("name must be a character string")
  }
  
  # if name starts with a number, add warning
  if(grepl("^[0-9]", name)) {
    stop("Table names should not start with a number")
  }
  
  # reserved name check
  reserved_names = c("intersect", "union", "except",
                     "select", "from", "where", "group", "by", "limit",
                     "create", "table", "insert")
  if(name %in% reserved_names){
    stop("Table name cannot be a RESERVED word. Try another name.")
  }
}

#' Input validation for geomName arg
#' @keywords internal
#' @noRd
.check_geomName <- function(tbl, geomName){
  
  if(!(geomName %in% colnames(tbl))) {
    stop("geomName not found in tbl")
  }
  
  # if name starts with a number, add warning
  if(grepl("^[0-9]", geomName)) {
    stop("Table names should not start with a number")
  }
  
  # reserved name check
  reserved_names = c("intersect", "union", "except",
                     "select", "from", "where", "group", "by", "limit",
                     "create", "table", "insert")
  if(geomName %in% reserved_names){
    stop("geomName cannot be a RESERVED word. Try another geomName")
  }
}

#' Input validation for overwrite arg
#' @keywords internal
#' @noRd
.check_overwrite <- function(conn, overwrite, name){
  if(overwrite == 'PASS') {
    return()
  }
  
  if(!is.logical(overwrite)) {
    stop("overwrite must be logical")
  }
  
  if(!overwrite & DBI::dbExistsTable(conn, name)){
    stop("Table already exists. Set overwrite = TRUE to overwrite the table.")
  }
}