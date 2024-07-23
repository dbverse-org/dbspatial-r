# setMethod('show', signature(object = 'dbSpatial'), function(object) {
#   # use proper getters
#   dbdir <- object@value[[1]]$con@driver@dbdir
#   numrow <- object@value |> dplyr::tally() |> dplyr::pull(n)
#   geomName <- object@geomName
#   isComputed <- ifelse(is.null(dbplyr::remote_name(object@value)), 'FALSE', 'TRUE')
#   
#   # print metadata
#   cat(crayon::bold('# dbSpatial object\n'))
#   cat('# connection: \t', dbdir, '\n')
#   cat('# table name: \t ', object@name, '\n', sep = '')
#   cat('# computed: \t ', isComputed, '\n', sep = '')
# 
#   # preview print #
#   # ------------- #
#   preview_dt <- object@value |>
#     dplyr::select(-!!geomName, !!geomName) |> # geomName printed last
#     dplyr::mutate(!!geomName := ST_AsText(!!sym(geomName))) |>
#   head(10) |>
#   data.table::as.data.table()
#   
#   preview_dt[,geomName] <- crayon::bold(preview_dt[,geomName])
#   
#   if(numrow > 10 ){
#     output <- as.matrix(preview_dt)
#     ellipsis_row = crayon::silver(rep('...', ncol(output)))
#     output <- rbind(output, ellipsis_row)
#     
#     rownames(output) <- c(crayon::blue(rownames(preview_dt)), crayon::silver("..."))
#     colnames(output) <- crayon::blue(colnames(preview_dt))
#   } else {
#     output <- as.matrix(preview_dt)
#     rownames(output) <- crayon::blue(rownames(preview_dt))
#     colnames(output) <- crayon::blue(colnames(preview_dt))
#   }
#   
#   write.table(output,
#               quote = FALSE,
#               row.names = TRUE,
#               col.names = NA,
#               sep = "\t",
#               file = "") 
# 
# })