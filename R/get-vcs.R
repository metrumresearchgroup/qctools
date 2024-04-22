#' @keywords internal
get_vcs <- function() {
  
  svnCheck <- tryCatch(processx::run("svn", c("info"), 
                                     wd = logDir(),
                                     error_on_status = FALSE))
  
  if (svnCheck$status == 0) {
    return("svn")
  } 
  
  gitCheck <- tryCatch(processx::run("git", c("log"), 
                                     wd = logDir(),
                                     error_on_status = FALSE))
  
  if (gitCheck$status == 0) {
    return("git")
  } 
  
  stop(logDir(), " is not a git or svn repository")
  
}