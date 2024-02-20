test_that("logCreate generates a QC log csv file with expected columns", {
  
  with_demoRepo({
    
    file.remove("QClog.csv")
    
    logCreate()
    
    path_to_qc_log <- file.path(logDir(), "QClog.csv")
    expect_true(file.exists(path_to_qc_log))
    
    col_headers <- readLines(path_to_qc_log)
    expect_equal("file,commit,reviewer,datetime", col_headers)
    
    expect_error(logCreate())
  })
})
