#' @keywords internal
absDir <- function(directory){
  
  # Make sure directory exists
  dirTest(directory)
  
  start <- getwd()
  setwd(directory)
  abs <- getwd()
  setwd(start)
  abs
}