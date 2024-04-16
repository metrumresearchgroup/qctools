test_that("logIgnore adds a line to the QC log and prevents file from appearing in other outputs", {
  
  with_demoRepo({
    
    path_to_qc_log <- file.path(logDir(),"QClog.csv")
    
    log <- logCheckRead()
    pending <- logPending()
    
    logIgnore("script/data-assembly.R")
    
    log_after_ignore <- logCheckRead()
    pending_after_ignore <- logPending()
    
    expect_true(nrow(log) == nrow(log_after_ignore) - 1)
    expect_true(nrow(pending) == nrow(pending_after_ignore) + 1)
    
    expect_true(! c("script/data-assembly.R") %in% pending_after_ignore$file)
    
  })
})
