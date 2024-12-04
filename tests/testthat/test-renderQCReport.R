if (Sys.getenv("METWORX_VERSION") != "") {
  
  with_demoRepo({
    
    test_that("renderQCReport works with valid directory", {
      
      renderQCReport(.output_dir = logDir())
      
      # Check that the output file was created
      expect_true(file.exists(file.path(logDir(), paste0("qc-report-", Sys.Date(), ".pdf"))))
      
    })
    
  })
  
}