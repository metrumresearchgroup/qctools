#' Approve a File
#' 
#' @description 
#' Add a row to the QC log accepting a file, recording the commit hash of the 
#' commit where the file's last modification occurred.
#' 
#' @param file file to accept in the QC log
#' 
#' @usage 
#' logAccept(file)
#' 
#' @export
logAccept <- function(file){
  
  git_commit <- gitLog(file)
  
  logEdit(
    .file = file,
    .reviewer = Sys.info()[["user"]],
    .commit = git_commit$commit
  )
  
}