# What should be tested?
# - Add files to a QC log, confirm the user and commit are as expected
# - Try to add the same file to the QC log twice, expect error

start <- getwd()

test_that("logAssign adds files to QC log with expected values", {
  
  setwd(demoRepo())
  
  path_to_qc_log <- file.path(logDir(),"QClog.csv")
  log <- logRead(path_to_qc_log)
  
  expect_true(unique(log$commit[log$reviewer == "anyone"]) == "Initial-Assignment")
  expect_true(unique(log$reviewer[log$commit == "Initial-Assignment"]) == "anyone")
  
  new_file <- "script/examp-yaml.yaml"
  
  logAssign(new_file)
  log_upd <- logRead(path_to_qc_log)
  
  expect_equal(log_upd$commit[log_upd$file == new_file], "Initial-Assignment")
  expect_equal(log_upd$reviewer[log_upd$file == new_file], "anyone")
  
  expect_error(logAssign(new_file))
})

setwd(start)
