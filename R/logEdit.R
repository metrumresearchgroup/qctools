#' @noRd
logEdit <- function(.file,
                    .reviewer,
                    .commit) {
  
  log <- logCheckRead()
  
  file_abs <- fs::path_abs(path = .file)
  
  if (!file.exists(file_abs)) {
    stop(paste0("File does not exist '", file_abs, "'"), call. = FALSE)
  }
  
  file_rel <- fs::path_rel(path = file_abs, start = logDir())
  
  if (any(log$file == file_rel) & .commit == "Initial-Assignment") {
    stop(
      paste0(
        "Cannot assign file '", file_rel, "' (already exists in QC log)"
      ),
      call. = FALSE
    )
  } 
  
  if (any(log$file == file_rel & log$commit == .commit)) {
    stop(
      paste0(
        file_rel, " already accepted in QC log at commit='", .commit, "'" 
      ),
      call. = FALSE
    )
  }
  
  new_row <-
    data.frame(
      file = file_rel,
      commit = .commit,
      reviewer = .reviewer,
      datetime = paste(as.character(as.POSIXlt(Sys.time(), "GMT")), "GMT")
    )
  
  logWrite(
    rbind(log, new_row),
    file= file.path(logDir(),"QClog.csv")
  )
}