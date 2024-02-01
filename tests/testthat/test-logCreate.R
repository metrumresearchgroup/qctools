# What should be tested?
# - Create a QC log with the expected column names
# - Make sure the QC log cannot be overwritten with logCreate()



test_that("logCreate generates a QC log csv file with expected columns", {
  
  setwd(demoGit())
  file.remove("QClog.csv")
  
  logCreate()
  
  path_to_qc_log <- file.path(logDir(), "QClog.csv")
  expect_true(file.exists(path_to_qc_log))
  
  col_headers <- readLines(path_to_qc_log)
  expect_equal("file,commit,reviewer,datetime", col_headers)
})

test_that("logCreate stops if asked to create QC log in directory it already exists", {
  expect_error(logCreate())
})