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
  
  path_to_qc_log <- file.path(absDir(directory),"QClog.csv")
  # Confirm directory exists
  dirTest(directory)
  # Confirm QC log has not already been created
  if (file.exists(path_to_qc_log)) {
    stop("QC log already exists")
  }
  
  logWrite(
    data.frame(
      file=character(0),
      commit=character(0),
      reviewer=character(0),
      time=character(0)
    ),
    file= path_to_qc_log
  )
}