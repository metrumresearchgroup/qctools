#' Visual diff of last QCed version of a file to the latest version.
#' 
#' @description 
#' Compares the latest version of a file with the most recent QCed version.
#' The output will appear in the viewer and only rows where there have been
#' additions, deletions or modifications in the file will be shown.
#'
#' @param file file path from working directory
#' @param side_by_side Logical. Should diffs be displayed side by side?
#' @param ignore_white_space Logical. Should white space be ignored?
#' 
#' @examples 
#' with_demoRepo({
#'   diffQced("script/data-assembly.R")
#' })
#' 
#' @export
diffQced <- function(file, side_by_side = TRUE, ignore_white_space = FALSE) {
  
  file_rel <- getRelativePath(file)
  
  log <- logCheckRead()
  
  log_accepts <- log[log$commit != "Initial-Assignment", ]
  log_file <- log_accepts[log_accepts$file == file_rel, "commit"]
  
  if (length(log_file) == 0) {
    stop(paste0(file, " not in QC log"), call. = FALSE)
  }
  
  version_new <- gitLog(file_rel, last_rev_only = TRUE)[["last_commit"]]
  version_qc <- log_file[length(log_file)]
  
  if (version_new == version_qc) {
    stop("File is up to date with QC", call. = FALSE)
  }
  
  message("Comparing local version of file '", file_rel, "' to QCed version")
  
  diffPreviousVersions(
    file = file_rel,
    previous_version = version_qc,
    current_version = version_new,
    side_by_side = side_by_side,
    ignore_white_space = ignore_white_space
  )
}
