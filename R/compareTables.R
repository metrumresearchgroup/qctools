#' Generate comparison between sets of tables
#' 
#' @description 
#' Generate a html document showing two versions of a figure (tex).
#' If two paths are provided, the local versions of both will be used.
#' If only one path is provided, the comparison will show the local 
#' versus last checked in version.
#' 
#' @param .path_current file or directory path to tables of interest
#' @param .path_previous .path_previous file or directory path to compare .path_base to (leave as NULL to compare to repo version)
#' @param .side_by_side Logical. Should outputs be displayed side by side?
#' 
#' @export
compareTables <- function(.path_current, 
                          .path_previous = NULL, 
                          .side_by_side = TRUE) {
  
  message(paste0("Checking '", .path_current, "' for files of type(s): ", "tex", "\n"))
  
  if (is.null(.path_previous)) {
    compareModified(
      .path = .path_current, 
      .side_by_side = .side_by_side, 
      .file_exts = c("tex")
    )
  } else {
    compareLocal(
      .path_base = .path_previous, 
      .path_compare = .path_current, 
      .side_by_side = .side_by_side,
      .file_exts = c("tex")
    )
  }
  
}