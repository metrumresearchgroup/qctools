#' @keywords internal
logRoot <- function(directory=getwd()){
  
  # Make sure the given directory exists
  dirTest(directory)
  
  start <- getwd()
  setwd(directory)
  root <- NULL
  parent <- parentDir(getwd())
  
  if (file.exists(logName(getwd()))) {
    root <- getwd()
  } else if(!is.null(parent)) {
    root <- logRoot(parent)
  }
  setwd(start)
  root
}