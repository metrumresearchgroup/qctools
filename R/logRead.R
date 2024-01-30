#' @keywords internal
logRead <- function(file) {
  utils::read.table(
    file,
    header = TRUE,
    sep = ",",
    as.is = TRUE,
    na.strings = ".",
    strip.white = TRUE
  )
}