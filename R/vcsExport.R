#' @keywords internal
vcsExport <- function(.file, 
                      .vcs, 
                      .version_new, 
                      .version_qc, 
                      .temp_new, 
                      .temp_qc) {
  
  if (.vcs == "git") {
    
    # Prepend "./" so that 'git cat-file' interprets the path relative to the
    # working directory rather than the top-level directory of the Git repo.
    commit_file_new <- paste0(.version_new, ":./", .file)
    commit_file_qc <- paste0(.version_qc, ":./", .file)
    
    processx::run(
      "git", c("cat-file", "blob", commit_file_new),
      stdout = .temp_new, wd = logDir())
    processx::run(
      "git", c("cat-file", "blob", commit_file_qc),
      stdout = .temp_qc, wd = logDir())
  }
  
  if (.vcs == "svn") {
    
    processx::run("svn", c("export", .file, paste0("-r", .version_new), .temp_new),
                  wd = logDir())
    
    processx::run("svn", c("export", .file, paste0("-r", .version_qc), .temp_qc),
                  wd = logDir())
    
  }
}