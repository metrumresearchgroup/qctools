#' @keywords internal
logRoot <- function(directory=here::here()){
  
  # Make sure the given directory exists
  dirTest(directory)
  
  start <- getwd()
  setwd(directory)
  root <- NULL
  parent <- parentDir(getwd())
  
  if (file.exists(file.path(absDir(getwd()),"QClog.csv"))) {
    root <- getwd()
  } else if(!is.null(parent)) {
    root <- logRoot(parent)
  }
  setwd(start)
  root
}