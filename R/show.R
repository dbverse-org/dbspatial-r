#' Show method for dbSpatial
#' @title show method for dbSpatial
#' @name show
#' @family dbSpatial
setMethod('show',
          signature(object = 'dbSpatial'),
          function(object) {
  # prepare show
  # preview <- object[] |> head(1) |> dplyr::collect()
  
  # geom_name <- .get_geomName(preview)
  
  # in cases where reading in spatial data and no geom
  # is present. e.g. parquet file
  # if(is.null(geom_name)){
  #   grey_color <- crayon::make_style("grey70")
  #   cat(grey_color("# Class:    dbSpatial \n"))
  #   cat(grey_color("# Extent:   NA\n"))
  #   return(show(object[]))
  # }
  
  # extent <- object |>
  #   st_extent(geomName = geom_name) |>
  #   unname() |>
  #   round(2) |> # round to 2 decimal places
  #   as.character()
  # labels_str <- paste(paste(extent, collapse = " "), "(xmin xmax ymin ymax)")

  # print metadata
  grey_color <- crayon::make_style("grey60")
  cat(grey_color("# Class:    dbSpatial \n"))
  # cat(grey_color("# Extent: ", labels_str, paste0("[", geom_name, "]"), "\n"))
  return(show(object[]))
})