#' Assign Files to QC Log
#' 
#' @description 
#' Appends a row to the QC log for the file given with the default reviewer
#' set to "anyone".  
#' 
#' @param file character file path (either the absolute or relative file path from the QC log)
#' @param reviewer specify a specific person to review the file
#' 
#' @examples 
#' \dontrun{ 
#' logAssign(file = tempfile(), reviewer = "anyone")
#' }
#' 
#' @export
logAssign <- function(file,
                      reviewer = "anyone") {
  
  logEdit(
    .file = file,
    .reviewer = reviewer,
    .commit = "Initial-Assignment"
  )
}

