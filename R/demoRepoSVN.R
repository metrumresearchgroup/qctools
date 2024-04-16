#' Create Demo SVN Repo
#' 
#' @description 
#' Create a SVN repo with files checked in and a QC log. The purpose of this 
#' demo repo is for the user to become familiar with using review functions. 
#' 
#' The files checked into the repo are at various stages in terms of their QC
#' status. This function returns the path to the repo, so that the user can set
#' their working directory to it.
#'
#' This demo repo is created under the R session `/tmp/` directory, so a new one
#' will need to be generated whenever the user restarts R.
#' 
#' @param clean Logical indicating if the temporary directory should be deleted after use
#' 
#' @usage demoRepo(clean = TRUE)
#'
#' @export
demoRepoSVN <- function(clean = TRUE) {
  
  repoInitPath <- withr::local_tempdir(
    "qctools-demo-svn-",
    clean = clean, 
    .local_envir = parent.frame()
  )
  
  processx::run("svnadmin", c("create", repoInitPath))
  repoDir <- file.path(repoInitPath, "svn-proj-123")

  processx::run("svn", c("co", paste0("file://", repoInitPath), repoDir, "-q"))
  
  withr::local_dir(repoDir)
  
  demoRepo_content1()
  
  # Check everything into SVN
  processx::run("svn", c("add", "--force", "."))
  processx::run("svn", c("commit", "-m", "'initial commit'", "-q", "-q"))
  
  logAssign("script/data-assembly.R")
  logAssign("script/pk/load-spec.R")
  logAssign("script/combine-da.R")
  logAssign("script/examp-txt.txt")
  
  processx::run("svn", c("add", "--force", "."))
  processx::run("svn", c("commit", "-m", "'logAssign scripts ready for QC'", "-q", "-q"))
  
  logAccept("script/data-assembly.R")
  logAccept("script/pk/load-spec.R")
  logAccept("script/combine-da.R")
  
  # Check in updates to QC log
  processx::run("svn", c("add", "--force", "."))
  processx::run("svn", c("commit", "-m", "'logAccept scripts ready for QC'", "-q", "-q"))
  
}