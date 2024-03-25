#' @keywords internal
createDiffMarkdown <- function(dfpaths, outputFileName = tempfile("diff-figure", fileext = ".Rmd")) {
  
  dfpaths$graphics <- paste0("knitr::include_graphics(c('", dfpaths$path1, "', '", dfpaths$path2, "'))")
  
  content <- 
    paste(
      "---",
      "title: \"Diff Figures\"",
      "output:",
      "  html_document:",
      "    toc: true",
      "---",
      sep = "\n")
  
  for (row.i in 1:nrow(dfpaths)) {
    
    content <- paste(
      content,
      paste0("# ", basename(dfpaths$path1[row.i])),
      "```{r out.height = 360}",
      dfpaths$graphics[row.i],
      "```",
      sep = "\n")
  }
  
  writeLines(content, con = outputFileName)
  cat("R Markdown template has been created with the name:", outputFileName, "\n")
  
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
