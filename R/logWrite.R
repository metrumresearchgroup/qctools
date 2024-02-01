#' @noRd
logWrite <- function(x,file) {
  utils::write.table(
    x,
    file=file,
    quote=FALSE,
    sep=",",
    na=".",
    row.names=FALSE
  )
}