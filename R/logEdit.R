#' @noRd
logEdit <- function(.file,
                    .reviewer,
                    .commit) {
  
  log <- logCheckRead()
  
  file_rel <- getRelativePath(.file)
  
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
      datetime = strftime(Sys.time(), tz = "GMT", usetz = TRUE)
    )
  
  logWrite(
    rbind(log, new_row),
    file= file.path(logDir(),"QClog.csv")
  )
}