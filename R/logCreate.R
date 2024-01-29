#' Create a QC Log
#' 
#' @description 
#' Creates an empty table in the directory specified with the name "QClog.csv".
#' 
#' @param directory directory in which to create the log file
#' 
#' @usage 
#' logCreate(directory=getwd())
#' 
#' @export
logCreate <- function(directory=getwd()){
  
  if (file.exists(logName(directory))) {
    stop("QC log already exists")
  }
  
  logWrite(
    data.frame(
      file=character(0),
      commit=character(0),
      reviewer=character(0),
      time=character(0)
    ),
    file=logName(directory)
  )
}