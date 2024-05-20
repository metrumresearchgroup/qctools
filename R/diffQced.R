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
  
  # Modify file to correct path format
  file_abs <- fs::path_abs(path = file)
  
  if (!file.exists(file_abs)) {
    stop(paste0("File does not exist '", file_abs, "'"), call. = FALSE)
  }
  
  file_rel <- fs::path_rel(path = file_abs, start = logDir())
  
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
  
  diffGenerate(
    file_rel = file_rel, 
    version_new = version_new, 
    version_prev = version_qc,
    banner_new = "Latest version", 
    banner_prev = "QCed version",
    side_by_side = side_by_side,
    ignore_white_space = ignore_white_space)
  
}