#' @keywords internal
parentDir <- function(directory=getwd()){
  directory <- absDir(directory)
  start <- getwd()
  setwd(directory)
  parent <- NULL
  if(file_test("-d","..")){
    setwd("..")
    if(getwd()!=absDir(directory)) {
      parent <- getwd()
    } 
  }
  setwd(start)
  parent
}