#' Create a QC Log
#' 
#' @description 
#' Creates an empty QC log file with the name "QClog.csv". This file will be
#' created in the directory where the RStudio project file (`*.Rproj`) exists.
#' 
#' @examples 
#' with_demoRepoGit({
#'   file.remove("QClog.csv")
#'   logCreate()
#' })
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