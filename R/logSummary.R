#' Returns QC Status of Files in QC log
#' 
#' @description 
#' Checks the files in the QC log and returns their QC status. Statuses include:
#' "Assigned, needs QC", "Modified, needs QC", and "Fully QCed".
#' 
#' @examples 
#' with_demoRepo({
#'   logSummary()
#' })
#' 
#' @export
logSummary <- function() {
  
  log <- logCheckRead()
  
  list_of_files <- unique(log$file)
  
  summary <- 
    data.frame(
      file=character(0),
      status=character(0)
    )
  
  for (file.i in list_of_files) {
    
    file_info.i <- gitLog(file.i)
    file_log.i <- log[log[["file"]] == file.i, ]
    
    if (nrow(file_log.i) == 1 & all(file_log.i$commit == "Initial-Assignment")) {
      status.i <- "Assigned, needs QC"
    } else if (file_log.i$commit[nrow(file_log.i)] == file_info.i$commit) {
      status.i <- "Fully QCed"
    } else {
      status.i <- "Modified, needs QC"
    }
    
    
    
    
    summary.i <-
      data.frame(
        file=file.i,
        status=status.i
      )
    
    rm(status.i)
    
    summary <- rbind(summary, summary.i)
  }
  
  summary
  
}