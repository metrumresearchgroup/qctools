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
  
  file_rel <- getRelativePath(file)
  
  log_res <- gitLog(file_rel, last_rev_only = FALSE)
  
  version_new <- log_res[1,][["last_commit"]]
  version_original <- log_res[nrow(log_res),][["last_commit"]]
  
  if (version_new == version_original) {
    stop("No differences between versions", call. = FALSE)
  }
  
  message("Comparing local version of file '", file_rel, "' to initial commit")
  
  diffPreviousVersions(
    file = file_rel,
    previous_version = version_original,
    current_version = version_new,
    side_by_side = side_by_side,
    ignore_white_space = ignore_white_space
  )
}
