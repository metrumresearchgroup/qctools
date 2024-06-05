#' @keywords internal
getModified <- function(.path, .exts = NULL) {
  
  .abs_path <- fs::path_abs(.path)
  
  status_run <- processx::run("git", c("status", .abs_path, "--porcelain"))$stdout
  
  if (status_run == "") {
    stop("No files are returned when running `git status`")
  }
  
  all_files_w_status <- unlist(strsplit(status_run, split = "\n"))
  files_of_interest <- all_files_w_status[grepl(pattern = "^\\s*M", x = all_files_w_status)]
  
  if (length(files_of_interest) == 0) {
    stop("No files are returned as modified when running `git status`")
  }
  
  # Remove "M" and leading white space
  files_of_interest <- gsub("^\\s*M\\s+", "", files_of_interest)
  files_of_interest <- gsub('\"', "", files_of_interest, fixed = TRUE)
  
  if(!is.null(.exts)){
    
    files_of_interest <- files_of_interest[tools::file_ext(files_of_interest) %in% .exts]
    
  }
  
  if (length(files_of_interest) == 0) {
    stop("No modified files found at '", .abs_path, "' versioned in git with extension(s) '", paste(.exts, collapse = " "), "'")
  }
  
  figures_meta <- data.frame()
  
  for (file.i in files_of_interest) {
    
    # Local version of the file
    info.i <- list(path1 = file.i, mtime1 = file.info(file.i)$mtime)
    # Convert mtime
    info.i$mtime1 <- as.POSIXct(format(info.i$mtime1, tz = "UTC"), tz = "UTC")
    # Git info of the file
    gitInfo.i <- gitLog(file.i, last_rev_only = TRUE)
    
    compareInfo.i <- list(mtime2 = gitInfo.i$last_datetime)
    
    commit_file_prev <- paste0(gitInfo.i$last_commit, ":./", file.i)
    tempfile_prev <- file.path(tempdir(), paste0("prev-", basename(file.i)))
    
    get_old_version <-
      processx::run(
        "git", c("cat-file", "blob", commit_file_prev),
        stdout = tempfile_prev, wd = logDir())
    
    compareInfo.i$path2 <- tempfile_prev
    
    compareInfo.i$compname <- basename(file.i)
    
    figures_meta <- rbind(figures_meta,
                          cbind(as.data.frame(info.i), as.data.frame(compareInfo.i)))
    
    message(paste0("Comparing: ", (fs::path_rel(file.i))))
    
  }
  figures_meta$path1 <- fs::path_abs(figures_meta$path1)
  figures_meta
}
