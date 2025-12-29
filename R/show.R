#' Show method for dbSpatial
#' @title show method for dbSpatial
#' @name show
#' @family dbSpatial
setMethod('show', signature(object = 'dbSpatial'), function(object) {
  # Header
  grey_color <- crayon::make_style("grey60")
  cat(grey_color("# Class:    dbSpatial \n"))
  
  # Access lazy table
  tbl <- object[]
  cols <- colnames(tbl)
  
  # Heuristic for geometry column
  geom_col <- if ("geom" %in% cols) "geom" else if ("geometry" %in% cols) "geometry" else NULL
  
  if (!is.null(geom_col)) {
    # Check if column is actually binary/blob (geometry) before wrapping
    # Some functions like st_is_valid overwrite 'geom' with boolean
    tryCatch({
      col_type <- object[] |> 
        dplyr::select(!!rlang::sym(geom_col)) |> 
        utils::head(0) |> 
        dplyr::collect() |> 
        {function(x) class(x[[1]])}()
      
      # If it's a blob/list (raw), treat as geometry and wrap
      # If it's logical, numeric, character, print as is
      if ("blob" %in% col_type || "list" %in% col_type || "vctrs_list_of" %in% col_type) {
         # Get max print length option
         max_len <- getOption("dbSpatial.max_print", default = 30)
         
         # Construct truncation SQL: CASE WHEN length(wkt) > max THEN left(wkt, max) || '...' ELSE wkt END
         # We use sprintf for cleaner string construction
         trunc_sql <- sprintf(
           "CASE WHEN length(ST_AsText(%s)) > %d THEN left(ST_AsText(%s), %d) || '...' ELSE ST_AsText(%s) END",
           geom_col, max_len, geom_col, max_len, geom_col
         )
         
         display_tbl <- tbl |>
          dplyr::mutate(!!rlang::sym(geom_col) := dplyr::sql(trunc_sql))
         print(display_tbl)
      } else {
        print(tbl)
      }
    }, error = function(e) {
      # Fallback on error (e.g. connection issues)
      print(tbl)
    })
  } else {
    print(tbl)
  }
})
