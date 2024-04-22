#' Returns QC Status of Files in QC log
#' 
#' @description 
#' Checks the files in the QC log and returns their QC status. Statuses include:
#' "Assigned, needs QC", "Modified, needs QC", and "Fully QCed".
#' 
#' @examples 
#' with_demoRepoGit({
#'   logSummary()
#' })
#' 
#' @export
logSummary <- function() {
  
  log <- logCheckRead()
  
  list_of_files <- unique(log$file)
  
  log_unique <- logUniquebyFile(list_of_files)
  
  getFiles <- vcsLastCommit(list_of_files = list_of_files)
  
  combineLog <- merge(log_unique, getFiles)
  
  combineLog$status <- ifelse(
    combineLog$commit == "Initial-Assignment", "Assigned - needs QC", 
    ifelse(combineLog$commit != combineLog$last_commit, "Modified - needs QC", "Fully QCed"))
  
  combineLog[c("file", "status")]
}