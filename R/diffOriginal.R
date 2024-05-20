#' Visual diff of original version of a file to the latest version.
#' 
#' @description 
#' Compares the latest version of a file to the initial version checked into
#' the repository. The output will appear in the viewer and only rows where 
#' there have been additions, deletions or modifications in the file will be shown.
#'
#' @param file file path from working directory
#' @param side_by_side Logical. Should diffs be displayed side by side?
#' @param ignore_white_space Logical. Should white space be ignored?
#' 
#' @examples 
#' with_demoRepo({
#'   diffOriginal("script/data-assembly.R")
#' })
#' 
#' @export
diffOriginal <- function(file, side_by_side = TRUE, ignore_white_space = FALSE) {
  
  # Modify file to correct path format
  file_abs <- fs::path_abs(path = file)
  
  if (!file.exists(file_abs)) {
    stop(paste0("File does not exist '", file_abs, "'"), call. = FALSE)
  }
  
  file_rel <- fs::path_rel(path = file_abs, start = logDir())
  
  log_res <- gitLog(file_rel, last_rev_only = FALSE)
  
  version_new <- log_res[1,][["last_commit"]]
  version_original <- log_res[nrow(log_res),][["last_commit"]]
  
  if (version_new == version_original) {
    stop("No differences between versions", call. = FALSE)
  }
  
  diffGenerate(
    file_rel = file_rel, 
    version_new = version_new, 
    version_prev = version_original,
    banner_new = "Latest version", 
    banner_prev = "Original version",
    side_by_side = side_by_side,
    ignore_white_space = ignore_white_space
    )
  
}