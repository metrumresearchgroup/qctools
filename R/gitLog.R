gitLog <- function(file) {
  
  file_abs <- fs::path_rel(path = file, start = logDir())
  
  outList <- list()
  
  p <- processx::run("git", c("log", "--format=%H%x09%an%x09%aI%x09", "-n1", "--", file))
  #p_out <- purrr::flatten_chr(stringr::str_split(p[["stdout"]], "\t"))
  p_out <- unlist(strsplit(p$stdout, split = "\t"))
  
  outList[["commit"]] <- p_out[1]
  outList[["author"]] <- p_out[2]
  outList[["datetime"]] <- p_out[3]
  
  return(outList)
}