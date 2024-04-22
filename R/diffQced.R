#' Visual diff of last QCed version of a file to the local version.
#' 
#' @description 
#' Compares the local version of a file with the most recent QCed version.
#' The output will appear in the viewer and only rows where there have been
#' additions, deletions or modifications in the file will be shown.
#'
#' @param file file path from working directory
#' 
#' @examples 
#' with_demoRepoGit({
#'   diffQced("script/data-assembly.R")
#' })
#' 
#' @export
diffQced <- function(file) {
  
  vcs <- get_vcs()
  
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

  version_new <- vcsLastCommit(file)[["last_commit"]]
  version_qc <- log_file[length(log_file)]
  
  if (version_new == version_qc) {
    stop("File is up to date with QC", call. = FALSE)
  }
  
  tempfile_new <- file.path(tempdir(), paste0("new-", basename(file_rel)))
  tempfile_qc <- file.path(tempdir(), paste0("qced-", basename(file_rel)))
  
  vcsExport(
    .file = file_rel,
    .vcs = vcs,
    .version_new = version_new,
    .version_qc = version_qc,
    .temp_new = tempfile_new,
    .temp_qc = tempfile_qc
    )
  
  diffobj::diffFile(
    target = tempfile_qc,
    current = tempfile_new, 
    color.mode = "rgb",
    mode = "sidebyside",
    tar.banner = "QCed version",
    cur.banner = "Current version",
    ignore.white.space = FALSE
  )
  
}