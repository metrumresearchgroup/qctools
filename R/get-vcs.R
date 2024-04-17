#' @keywords internal
get_vcs <- function() {
  
  svnCheck <- tryCatch(processx::run("svn", c("info"), error_on_status = FALSE))
  gitCheck <- tryCatch(processx::run("git", c("log"), error_on_status = FALSE))
  
  if (svnCheck$status == 0) {
    return("svn")
  } 
  
  if (gitCheck$status == 0) {
    return("git")
  } 
  
  stop(logDir(), " is not a git or svn repository")
  
}