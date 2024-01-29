#' Assign Files to QC Log
#' 
#' @description 
#' Appends a row to the QC log for the file given with the default reviewer
#' set to "anyone".  
#' 
#' @param file a character vector of filenames (paths) relative to directory
#' @param directory the parent of the file
#' @param reviewer specify a specific person to review the file
#' 
#' @usage 
#' logAssign(
#'  file = tempfile(), 
#'  directory = getwd())
#' 
#' @export
logAssign <- function(file,
                      directory=getwd(),
                      reviewer = "anyone") {
  
  # file should be able to be given as relative path, path with ../ or here::here
  # user should be able to specify a reviewer
  # default commit of "None" should be added to the table
  # one row should be added to the QC log
  # Should not be able to add multiple rows for the same file
  
  commit <- "None"
  
  data.frame(
    file=relPath(file=file,directory=directory),
    commit = commit,
    reviewer = reviewer,
    time=paste(as.character(as.POSIXlt(Sys.time(), "GMT")),"GMT")
  )
  
  logAppend(
    new=logQueue(file=file,directory=directory,origin=origin,...),
    directory=logRoot(directory)
  )
}
