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
  
  log_unique <- logUniquebyFile(list_of_files)
  
  gitFiles <- gitLog(list_of_files = list_of_files)
  
  combineLogGit <- merge(log_unique, gitFiles)
  
  combineLogGit$status <- ifelse(
    combineLogGit$commit == "Initial-Assignment", "Assigned - needs QC", 
    ifelse(combineLogGit$commit != combineLogGit$last_commit, "Modified - needs QC", "Fully QCed"))
  
  combineLogGit[c("file", "status")]
}