#' List Files that Require QC
#' 
#' @description 
#' Checks the files in the QC log and returns those that are not up to date with
#' QC, meaning files that have only been assigned or have had modifications since
#' their last QC was completed. 
#' 
#' @examples 
#' with_demoRepo({
#'   logPending()
#' })
#' 
#' @export
logPending <- function() {
  
  log <- logCheckRead()
  
  list_of_files <- unique(log$file)
  
  log_unique <- logUniquebyFile(list_of_files)
  
  # Combine gitLog output for files with log_unique
  gitFiles <- gitLog(list_of_files = list_of_files)
  combineLogGit <- merge(log_unique, gitFiles)
  filterLogGit <- combineLogGit[combineLogGit$commit != combineLogGit$last_commit,]
  
  filterLogGit[c("file", "last_author", "reviewer", "datetime")]
}