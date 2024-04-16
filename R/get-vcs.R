#' @keywords internal
get_vcs <- function() {
  
  all_files <- list.files(logDir(), all.files = TRUE)
  
  if (".svn" %in% all_files) {
    return("svn")
  } 
  
  if (".git" %in% all_files) {
    return("git")
  } 
  
  stop(logDir(), " is not a git or svn repository")
  
}