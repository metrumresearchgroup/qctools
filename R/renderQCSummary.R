#' Render a QC Summary Document
#'
#' This function generates a QC summary based on scripts within a given project 
#' and renders it into a PDF report. 
#' 
#' A high level summary of all scripts that need to be QCed will be displayed along
#' with a summary of recently modified scripts that have not been assigned to the QC log.
#'
#' @param .output_dir Character string (optional). Path to the directory where the output PDF 
#'   should be saved. If not provided, the document will not be saved locally.
#'
#' @return Invisible. The function will save a PDF report named "qc-summary-(current date).pdf"
#'   to the specified output directory (if available). If the R session is interactive, it will also 
#'   open the PDF in the default browser.
#'   
#' @examples 
#' \dontrun{
#'   with_demoRepo({
#'     renderQCSummary()
#'   })
#' }
#'
#' @export
renderQCSummary <- function(.output_dir = NULL) {
  
  if (is.null(.output_dir)) {
    .output_dir <- tempdir()
  } else {
    if (!dir.exists(.output_dir)) {
      stop(.output_dir, " does not exist")
    }
  }
  
  output_file <- paste0("qc-summary-", Sys.Date(), ".pdf")
  output_path <- file.path(.output_dir, output_file)
  
  params_in <- list(
    project = basename(logDir()),
    repoHistory = repoHistory(),
    logSum = logSummary(),
    qcLog = logCheckRead(),
    logPending = logPending()
  )
  
  rmarkdown::render(
    input = system.file("templates", "QCSummary.Rmd", package = "qctools"),
    output_file = output_path,
    params = params_in,
    envir = new.env(),
    quiet = TRUE
  )
  
  if (interactive()) {
    utils::browseURL(output_path)
  }
  
}
