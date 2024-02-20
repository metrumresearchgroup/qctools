#' Get commit info of last modified version of a file
#' 
#' @description 
#' Returns a list including the commit hash, last author and datetime of last 
#' commit for a specific file. 
#' 
#' @param file character file path (either the absolute or relative file path from the QC log)
#' 
#' @examples 
#' with_demoRepo({
#'   gitLog("script/examp-txt.txt")
#' })
#' 
#' @export
gitLog <- function(file) {
  
  file_abs <- fs::path_abs(path = file)
  
  if (!file.exists(file_abs)) {
    stop(paste0("File does not exist '", file_abs, "'"), call. = FALSE)
  }
  
  file_rel <- fs::path_rel(path = file_abs, start = logDir())
  
  outList <- list()
  
  p <- processx::run("git", c("log", "--format=%H%x09%an%x09%aI%x09", "-n1", "--", file_rel))
  p_out <- unlist(strsplit(p$stdout, split = "\t"))
  
  outList[["commit"]] <- p_out[1]
  outList[["author"]] <- p_out[2]
  outList[["datetime"]] <- p_out[3]
  
  return(outList)
}