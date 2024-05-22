#' Get commit info of last modified version of a file
#' 
#' @description 
#' Returns a data.frame including the commit hash, last author and datetime of all 
#' commits for all input files. 
#' 
#' @param list_of_files vector of file paths (can also pass only 1 file)
#' @param last_rev_only if set to TRUE will only return the last commit, author and datetime of last revision
#' 
#' @examples 
#' with_demoRepo({
#'   gitLog("script/examp-txt.txt")
#' })
#' 
#' @export
gitLog <- function(list_of_files, last_rev_only = FALSE) {
  
  outDF <- data.frame()
  
  for (file.i in list_of_files) {
    
    file_rel <- getRelativePath(file.i)
    
    p <- processx::run("git", c("--literal-pathspecs", "log", "--format=%H%x09%an%x09%aI%x09", "--", file_rel), wd = logDir())
    
    if (length(length(p$stdout)) != 1) {
      stop(paste0("Could not find git history of '", file_rel, "'"), call. = FALSE)
    }
    
    all_history <- strsplit(unlist(strsplit(p$stdout, split = "\n")), split = "\t")
    
    if(last_rev_only) {
      all_history <- all_history[1]
    }
    
    for (i in 1:length(all_history)) {
      
      tmp_list <- all_history[[i]]
      
      outDF <-
        rbind(
          outDF,
          data.frame(
            file = file_rel,
            last_commit = tmp_list[1],
            last_author = tmp_list[2],
            last_datetime = tmp_list[3]
          )
        )
      
    }
  }
  return(outDF)
}
