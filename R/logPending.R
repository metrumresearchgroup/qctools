#' List Files that Require QC
#' 
#' @description 
#' Checks the files in the QC log and returns those that are not up to date with
#' QC, meaning files that have only been assigned or have had modifications since
#' their last QC was completed. 
#' 
#' @examples 
#' with_demoRepo({
#'   logPending()
#' })
#' 
#' @export
logPending <- function() {
  
  log <- logCheckRead()
  
  list_of_files <- unique(log$file)
  
  pending <- 
    data.frame(
      file=character(0),
      author=character(0),
      reviewer = character(0),
      datetime=character(0)
    )
  
  for (file.i in list_of_files) {
    
    file_info.i <- gitLog(file.i)
    file_log.i <- log[log[["file"]] == file.i, ]
    
    if (file_log.i$commit[nrow(file_log.i)] == file_info.i$commit) {
      next
    }
    
    pending.i <-
      data.frame(
        file=file.i,
        author=file_info.i$author,
        reviewer = file_log.i$reviewer[nrow(file_log.i)],
        datetime = as.Date(file_info.i$datetime)
      )
    
    pending <- rbind(pending, pending.i)
  }
  
  pending
  
}