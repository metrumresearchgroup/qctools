#' @keywords internal
dirTest <- function(directory) {
  if (!utils::file_test("-d",directory)){
    stop(paste("nonexistent directory:",directory))
  }
}