#' @keywords internal
absDir <- function(directory){
  
  if (missing(directory)) {
    stop("argument 'directory' is missing")
  }
  
  start <- getwd()
  
  if (!utils::file_test("-d",directory)) {
    stop(paste("nonexistent directory:",directory))
  }
  
  setwd(directory)
  abs <- getwd()
  setwd(start)
  abs
}