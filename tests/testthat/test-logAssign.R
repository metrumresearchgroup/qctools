test_that("logAssign adds files to QC log with expected values", {
  
  with_demoRepo({
    
    log <- logCheckRead()
    
    path_to_qc_log <- file.path(logDir(),"QClog.csv")
    
    expect_true(unique(log$commit[log$reviewer == "anyone"]) == "Initial-Assignment")
    expect_true(unique(log$reviewer[log$commit == "Initial-Assignment"]) == "anyone")
    
    new_file <- "script/examp-yaml.yaml"
    
    logAssign(new_file)
    log_upd <- logRead(path_to_qc_log)
    
    expect_equal(log_upd$commit[log_upd$file == new_file], "Initial-Assignment")
    expect_equal(log_upd$reviewer[log_upd$file == new_file], "anyone")
    
    expect_error(logAssign(new_file))
  })
})

test_that("logAssign works with variation of paths provided", {
  
  with_demoRepo({
    
    path_to_qc_log <- file.path(logDir(),"QClog.csv")
    
    setwd("script")
    
    logAccept("examp-yaml.yaml")
    log <- logRead(path_to_qc_log)
    
    expect_true("script/examp-yaml.yaml" %in% log$file)
  })
})

test_that("logAssign adds files to QC log with expected values within SVN", {
  
  with_demoRepoSVN({
    
    log <- logCheckRead()
    
    path_to_qc_log <- file.path(logDir(),"QClog.csv")
    
    expect_true(unique(log$commit[log$reviewer == "anyone"]) == "Initial-Assignment")
    expect_true(unique(log$reviewer[log$commit == "Initial-Assignment"]) == "anyone")
    
    new_file <- "script/examp-yaml.yaml"
    
    logAssign(new_file)
    log_upd <- logRead(path_to_qc_log)
    
    expect_equal(log_upd$commit[log_upd$file == new_file], "Initial-Assignment")
    expect_equal(log_upd$reviewer[log_upd$file == new_file], "anyone")
    
    expect_error(logAssign(new_file))
  })
})
