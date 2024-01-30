#' Create a QC Log
#' 
#' @description 
#' Creates an empty table in the directory specified with the name "QClog.csv".
#' By default, the csv will be created in the directory where the R studio 
#' project exists. 
#' 
#' @usage 
#' logCreate()
#' 
#' @export
logCreate <- function(){
  
  path_to_qc_log <- file.path(logDir(),"QClog.csv")
  
  if (file.exists(path_to_qc_log)) {
    stop("QC log already exists")
  }
  
  logWrite(
    data.frame(
      file=character(0),
      commit=character(0),
      reviewer=character(0),
      datetime=character(0)
    ),
    file= path_to_qc_log
  )
}