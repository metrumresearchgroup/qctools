#' @noRd
logCheckRead <- function() {
  path_to_qc_log <- file.path(logDir(),"QClog.csv")
  
  if (!file.exists(path_to_qc_log)) {
    stop("No QC log found", call. = FALSE)
  }
  
  logRead(path_to_qc_log)
}