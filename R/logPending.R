#' List Files that Require QC
#' 
#' @description 
#' Checks the files in the QC log and returns those that are not up to date with
#' QC, meaning files that have only been assigned or have had modifications since
#' their last QC was completed. 
#' 
#' @examples 
#' with_demoRepoGit({
#'   logPending()
#' })
#' 
#' @export
logPending <- function() {
  
  log <- logCheckRead()
  
  list_of_files <- unique(log$file)
  
  log_unique <- logUniquebyFile(list_of_files)
  
  # Combine vcsLastCommit output for files with log_unique
  versionedFiles <- vcsLastCommit(list_of_files = list_of_files)
  combineLog <- merge(log_unique, versionedFiles)
  filterLog <- combineLog[combineLog$commit != combineLog$last_commit,]
  
  filterLog[c("file", "last_author", "reviewer", "datetime")]
}