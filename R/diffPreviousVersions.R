#' Visual diff of previous version of a file to the latest version.
#' 
#' @description 
#' Compares the current version of a script with a previous revision.
#' The output will appear in the viewer and only rows where there have been
#' additions, deletions or modifications in the script will be shown.
#' 
#' The user can also provide two previous versions 
#'
#' @param file file path from working directory
#' @param previous_revision commit hash of version to compare to current revision
#' @param current_revision current version (defaults to local copy)
#' @param side_by_side Logical. Should diffs be displayed side by side?
#' @param ignore_white_space Logical. Should white space be ignored?
#' 
#' @examples 
#' with_demoRepo({
#' 
#'  prev_version <- gitLog("script/data-assembly.R")[2,][["last_commit"]]
#'  
#'  diffPreviousVersions(file = "script/data-assembly.R", 
#'                        previous_revision = prev_version)
#' })
#' 
#' @export
diffPreviousVersions <- function(file,
                                 previous_revision,
                                 current_revision = NULL,
                                 side_by_side = TRUE,
                                 ignore_white_space = FALSE){
  
  # Modify file to correct path format
  file_abs <- fs::path_abs(path = file)
  
  if (!file.exists(file_abs)) {
    stop(paste0("File does not exist '", file_abs, "'"), call. = FALSE)
  }
  
  file_rel <- fs::path_rel(path = file_abs, start = logDir())
  
  latest_ver <- gitLog(file_rel, last_rev_only = TRUE)[["last_commit"]]
  
  diffGenerate(
    file_rel = file_rel, 
    version_new = latest_ver, 
    version_prev = previous_revision,
    banner_new = paste0("Latest version (", substr(latest_ver, 1, 7), ")"),
    banner_prev = paste0("Previous version (", substr(previous_revision, 1, 7), ")"),
    side_by_side = side_by_side,
    ignore_white_space = ignore_white_space
  )
}