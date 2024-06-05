#' Assign Files to QC Log
#' 
#' @description 
#' Adds a row to the QC log for the file given with the default reviewer
#' set to "anyone". 
#' 
#' @details 
#' The purpose of `logAssign()` is to indicate a file is ready for QC. This
#' will allow the file to appear on the output of `logPending()`.
#' 
#' @param file character file path (either the absolute or relative file path from the QC log)
#' @param reviewer specify a specific person to review the file (defaults to "anyone")
#' 
#' @examples 
#' with_demoRepo({
#'   logAssign(
#'     file = "script/data-prep.R", 
#'     reviewer = "person1")
#' })
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

