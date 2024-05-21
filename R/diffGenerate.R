#' @keywords internal
diffGenerate <- function(file_rel, 
                         version_new, 
                         version_prev, 
                         banner_new = NULL, 
                         banner_prev = NULL,
                         side_by_side = TRUE,
                         ignore_white_space = FALSE) {
  
  # Prepend "./" so that 'git cat-file' interprets the path relative to the
  # working directory rather than the top-level directory of the Git repo.
  commit_file_new <- paste0(version_new, ":./", file_rel)
  commit_file_prev <- paste0(version_prev, ":./", file_rel)
  
  tempfile_new <- file.path(tempdir(), paste0("new-", basename(file_rel)))
  tempfile_prev <- file.path(tempdir(), paste0("prev-", basename(file_rel)))
  
  processx::run(
    "git", c("cat-file", "blob", commit_file_new),
    stdout = tempfile_new, wd = logDir())
  processx::run(
    "git", c("cat-file", "blob", commit_file_prev),
    stdout = tempfile_prev, wd = logDir())
  
  if (is.null(banner_prev)) {
    banner_prev <- basename(tempfile_prev)
  }
  
  if (is.null(banner_new)) {
    banner_new <- basename(tempfile_new)
  }
  
  diffobj::diffFile(
    target = tempfile_prev,
    current = tempfile_new, 
    color.mode = "rgb",
    mode = ifelse(side_by_side, "sidebyside", "unified"),
    tar.banner = banner_prev,
    cur.banner = banner_new,
    ignore.white.space = ignore_white_space
  )
}
