# What should be tested?
# - Create a QC log with the expected column names
# - Make sure the QC log cannot be overwritten with logCreate()
# - Create the QC log in a different directory than working directory

temp_loc <- tempdir()
original_wd <- getwd()
setwd(temp_loc)

test_that("logCreate generates a QC log csv file with expected columns", {
  
  logCreate()
  path_to_qc_log <- file.path(temp_loc, "QClog.csv")
  
  expect_true(file.exists(path_to_qc_log))
  
  col_headers <- readLines(path_to_qc_log)
  expect_equal("file,commit,reviewer,time", col_headers)
})

test_that("logCreate stops if asked to create QC log in directory it already exists", {
  expect_error(logCreate())
})

# Remove QC log for same session re-run of above tests
file.remove(file.path(temp_loc, "QClog.csv"))

test_that("logCreate can create QC log in directory that isn't working directory", {
  
  new_dir <- file.path(temp_loc, "newDir")
  
  if (!dir.exists(new_dir)) {
    dir.create(new_dir)
  }
  
  logCreate(directory = "newDir")
  expect_true(file.exists(file.path(new_dir, "QClog.csv")))
  
  expect_error(logCreate(directory = "newDir"))
  
  # Remove QC log for same session re-run of above tests
  file.remove(file.path(new_dir, "QClog.csv"))
})

setwd(original_wd)
