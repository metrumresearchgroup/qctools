# What should be tested?
# - Add files to a QC log, confirm the user and commit are as expected
# - Try to add the same file to the QC log twice, expect error

setwd(demoGit())

path_to_qc_log <- file.path(logDir(),"QClog.csv")
log <- logRead(path_to_qc_log)

test_that("logAssign adds files to QC log with expected values", {
  
  expect_true(unique(log$commit[log$reviewer == "anyone"]) == "assigned")
  expect_true(unique(log$reviewer[log$commit == "assigned"]) == "anyone")
})


