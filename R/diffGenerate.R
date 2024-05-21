#' @keywords internal
diffGenerate <- function(file_rel, 
                         version_new, 
                         version_prev, 
                         banner_new, 
                         banner_prev,
                         side_by_side = TRUE,
                         ignore_white_space = FALSE) {
  
  # Prepend "./" so that 'git cat-file' interprets the path relative to the
  # working directory rather than the top-level directory of the Git repo.
  commit_file_new <- paste0(version_new, ":./", file_rel)
  commit_file_qc <- paste0(version_prev, ":./", file_rel)
  
  tempfile_new <- file.path(tempdir(), paste0("new-", basename(file_rel)))
  tempfile_qc <- file.path(tempdir(), paste0("qced-", basename(file_rel)))
  
  processx::run(
    "git", c("cat-file", "blob", commit_file_new),
    stdout = tempfile_new, wd = logDir())
  processx::run(
    "git", c("cat-file", "blob", commit_file_qc),
    stdout = tempfile_qc, wd = logDir())
  
  diffFiles(
    file_1 = tempfile_qc, 
    file_2 = tempfile_new, 
    banner_1 = banner_prev, 
    banner_2 = banner_new, 
    side_by_side = side_by_side,
    ignore_white_space = ignore_white_space
  )
}
