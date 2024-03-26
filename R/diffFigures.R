#' @export
diffFigures <- function(figure1, figure2 = NULL) {
  
  if (!file.exists(figure1)) {
    stop(figure1, " does not exist")
  }
  
  if (is.null(figure2)) {
    figure2 <- getRepoVersion(figure1)
  }
  
  if (!file.exists(figure2)) {
    stop(figure2, " does not exist")
  }
  
  dfpaths <-
    data.frame(
      path1 = figure1,
      path2 = figure2
    )
  
  dfpaths$graphics <- paste0("knitr::include_graphics(c('", dfpaths$path1, "', '", dfpaths$path2, "'))")
  
  content <- 
    paste(
      "---",
      "title: \"Diff Figures\"",
      "date: '`r Sys.time()`'",
      "output:",
      "  html_document:",
      "    toc: true",
      "    toc_float:",
      "      collapsed: true",
      "---",
      sep = "\n")
  
  for (row.i in 1:nrow(dfpaths)) {
    
    content <- paste(
      content,
      paste0("# ", basename(dfpaths$path1[row.i])),
      "```{r out.height = 360, echo=FALSE}",
      dfpaths$graphics[row.i],
      "```",
      sep = "\n")
  }
  
  outputFileName = tempfile("diff-figure", fileext = ".Rmd")
  
  writeLines(content, con = outputFileName)
  
  # output ------------------------------------------------------------------
  temp_out <- tempfile(fileext = ".html")
  
  rmarkdown::render(
    outputFileName,
    output_file = temp_out,
    envir = new.env(),
    quiet = TRUE
  )
  
  if (interactive()) {
    utils::browseURL(temp_out)
  }
}