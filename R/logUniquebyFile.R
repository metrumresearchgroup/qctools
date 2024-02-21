#' @noRd
logUniquebyFile <- function(list_of_files) {
  
  log <- logCheckRead()
  
  # Filter to only last entry for each file
  log_unique <- data.frame()
  
  for (file.i in list_of_files) {
    
    log.i <- log[log$file == file.i,]
    
    log_unique <-
      rbind(
        log_unique,
        log.i[nrow(log.i),]
      )
  }
  
  stopifnot(length(list_of_files) == nrow(log_unique))
  
  log_unique
}