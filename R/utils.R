#' @keywords internal
.st_mutate_geom <- function(dbSpatial, st_func, geomName = "geom", dest_col = NULL, args = list(), param_names = NULL) {
  # Access underlying lazy table and validate inputs
  tbl <- dbSpatial[] 
  .check_tbl(tbl = tbl)
  .check_geomName(value = tbl, geomName = geomName)
  
  # Determine target: overwrite existing geometry or create new column
  target_col <- if (is.null(dest_col)) geomName else dest_col
  
  # Handle argument mapping: R (named/unordered) -> SQL (positional/strict)
  if (!is.null(param_names) && length(args) > 0 && !is.null(names(args))) {
    
    # Warn on unknown arguments
    unknown_args <- setdiff(names(args), param_names)
    if (length(unknown_args) > 0) {
      warning(paste("Unknown arguments passed to SQL translation:", paste(unknown_args, collapse=", ")))
    }
    
    # Enforce strict SQL parameter ordering based on 'param_names'
    # intersect(A, B) preserves the order of A, ensuring args align with SQL signature
    ordered_names <- intersect(param_names, names(args))
    args <- args[ordered_names]
  }
  
  # Strip names to ensure positional SQL generation (e.g., ST_Func(geom, val) not ST_Func(geom, arg=val))
  args <- unname(args)
  
  # Construct and inject the lazy SQL expression
  call_expr <- rlang::call2(st_func, rlang::sym(geomName), !!!args)
  
  # Apply mutation to the lazy query
  new_obj <- dbSpatial
  new_obj@value <- tbl |>
    dplyr::mutate(!!target_col := !!call_expr)
    
  return(new_obj)
}