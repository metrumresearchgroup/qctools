#' Get commit info of last modified version of a file
#' 
#' @description 
#' Returns a data.frame including the commit hash, last author and datetime of last 
#' commit for all input files. 
#' 
#' @param list_of_files vector of file paths (can also pass only 1 file)
#' 
#' @examples 
#' with_demoRepo({
#'   gitLog("script/examp-txt.txt")
#' })
#' 
#' @export
gitLog <- function(list_of_files) {
  
  outDF <- data.frame()
  
  for (file.i in list_of_files) {
    
    file_abs <- fs::path_abs(path = file.i)
    
    if (!file.exists(file_abs)) {
      stop(paste0("File does not exist '", file_abs, "'"), call. = FALSE)
    }
    
    file_rel <- fs::path_rel(path = file_abs, start = logDir())
    
    p <- processx::run("git", c("--literal-pathspecs", "log", "--format=%H%x09%an%x09%aI%x09", "-n1", "--", file_rel), wd = logDir())
    
    if (length(length(p$stdout)) != 1) {
      stop(paste0("Could not find git history of '", file_abs, "'"), call. = FALSE)
    }
    
    p_out <- unlist(strsplit(p$stdout, split = "\t"))
    
    outDF <-
      rbind(
        outDF,
        data.frame(
          file = file_rel,
          last_commit = p_out[1],
          last_author = p_out[2],
          last_datetime = p_out[3]
        )
      )
  }
  
  return(outDF)
}