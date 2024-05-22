#' Visual diff of two versions of a file.
#' 
#' @description 
#' Compares two versions of a file. The output will appear in the viewer 
#' and only rows where there have been additions, deletions or 
#' modifications in the file will be shown.
#'
#' @param file file path from working directory
#' @param previous_version commit hash of version to compare to current revision
#' @param current_version current version (defaults to local copy)
#' @param banner_cur Header for first file in viewer
#' @param banner_prev Header for second file in viewer
#' @param side_by_side Logical. Should diffs be displayed side by side?
#' @param ignore_white_space Logical. Should white space be ignored?
#' 
#' @examples 
#' with_demoRepo({
#' 
#'  prev_version <- gitLog("script/data-assembly.R")[2,][["last_commit"]]
#'  
#'  diffPreviousVersions(file = "script/data-assembly.R", 
#'                        previous_version = prev_version)
#' })
#' 
#' @export
diffPreviousVersions <- function(file,
                                 previous_version,
                                 current_version = NULL,
                                 banner_cur = NULL,
                                 banner_prev = NULL,
                                 side_by_side = TRUE,
                                 ignore_white_space = FALSE){
  
  file_rel <- getRelativePath(file)
  
  if (is.null(current_version)) {
    current_version <- gitLog(file_rel, last_rev_only = TRUE)[["last_commit"]]
  }
  
  if(is.null(banner_cur)) {
    banner_cur <- paste0("Current version (", substr(current_version, 1, 7), ")")
  }
  
  if(is.null(banner_prev)) {
    banner_prev <- paste0("Previous version (", substr(previous_version, 1, 7), ")")
  }

  diffGenerate(
    file_rel = file_rel, 
    version_new = current_version, 
    version_prev = previous_version,
    banner_new = banner_cur,
    banner_prev = banner_prev,
    side_by_side = side_by_side,
    ignore_white_space = ignore_white_space
  )
}
