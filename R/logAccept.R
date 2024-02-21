#' Approve a File in the QC log
#' 
#' @description 
#' Add a row to the QC log accepting a file, recording the commit hash of the 
#' commit where the file's last modification occurred. The username of the
#' reviewer will be included in the new row as well.
#' 
#' @param file character file path (either the absolute or relative file path from the QC log)
#' 
#' @examples 
#' with_demoRepo({
#'   logAccept(file = "script/data-assembly.R")
#' })
#' 
#' @export
logAccept <- function(file){
  
  git_commit <- gitLog(file)
  
  logEdit(
    .file = file,
    .reviewer = Sys.info()[["user"]],
    .commit = git_commit$last_commit
  )
  
}