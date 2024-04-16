#' Mark files to ignore when checking QC status
#' 
#' @description 
#' Adds a row to the QC log for the file given to indicate the file no longer
#' requires QC.
#' 
#' @details 
#' The purpose of `logIgnore()` is to indicate a file no longer requires QC. This
#' will allow the file to not appear on the output of `logPending()`.
#' 
#' @param file character file path (either the absolute or relative file path from the QC log)
#' 
#' @examples 
#' with_demoRepo({
#'   logIgnore(
#'     file = "script/data-assembly.R")
#' })
#' 
#' @export
logIgnore <- function(file) {

  logEdit(
    .file = file,
    .reviewer = Sys.info()[["user"]],
    .commit = "Ignore"
  )
}
