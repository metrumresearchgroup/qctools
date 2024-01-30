logEdit <- function(file,
                    reviewer,
                    commit) {
  
  file_abs <- fs::path_rel(path = file, start = logDir())
  path_to_qc_log <- file.path(logDir(),"QClog.csv")
  
  if (!file.exists(file_abs)) {
    stop(paste("nonexistent file -", fs::path_abs(path = file)))
  }
  
  if (!file.exists(path_to_qc_log)) {
    stop("No QC log found")
  }
  
  log <- logRead(path_to_qc_log)
  
  # Check if file is already assigned
  if (file_abs %in% log$file & commit == "assigned") {
    stop(paste(file, " has already been assigned"))
  }
  
  new_row <-
    data.frame(
      file = file_abs,
      commit = commit,
      reviewer = reviewer,
      datetime = paste(as.character(as.POSIXlt(Sys.time(), "GMT")), "GMT")
    )
  
  logWrite(
    rbind(log, new_row),
    file= path_to_qc_log
  )
}