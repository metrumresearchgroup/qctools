if (Sys.getenv("METWORX_VERSION") != "") {
  
  with_demoRepo({
    
    test_that("renderQCSummary works with valid directory", {
      
      expect_null({
        renderQCSummary(.output_dir = logDir())
      })
      
      # Check that the output file was created
      expect_true(file.exists(file.path(logDir(), paste0("qc-summary-", Sys.Date(), ".pdf"))))
      
    })
    
    test_that("renderQCSummary doesn't save file if directory not given", {
      
      temp_dir <- tempdir()
      
      expect_null({
        renderQCSummary()
      })
      
      # Check that the output file was created
      expect_true(file.exists(file.path(temp_dir, paste0("qc-summary-", Sys.Date(), ".pdf"))))
      
    })
    
  })

}
