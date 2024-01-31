# What should be tested?
# - Add files to a QC log, confirm the user and commit are as expected
# - Try to add the same file to the QC log twice, expect error

temp_loc <- tempdir()
original_wd <- getwd()
setwd(temp_loc)

test_that("logAssign adds files to QC log with expected values", {
  
  logCreate()
  
  file1 <- tempfile(fileext = ".R")
  file2 <- tempfile(fileext = ".R")
  file3 <- tempfile(fileext = ".R")
  
  file.create(file1)
  file.create(file2)
  file.create(file3)
  
  logAssign(file1)
  logAssign(file2)
  logAssign(file3)
  
  path_to_qc_log <- file.path(logDir(),"QClog.csv")
  log <- logRead(path_to_qc_log)
  
  expect_true(unique(log$commit) == "assigned")
  expect_true(unique(log$reviewer) == "anyone")
  
  expect_equal(log$file[1], basename(file1))
  expect_equal(log$file[2], basename(file2))
  expect_equal(log$file[3], basename(file3))
  
  expect_error(logAssign(file1))
  file.remove(file.path(logDir(), "QClog.csv"))
})


setwd(original_wd) 

