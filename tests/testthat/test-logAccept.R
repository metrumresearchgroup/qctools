# What should be tested?
# - Accept files to a QC log, commit is the same as output of gitLog
# - Error if trying to accept the same commit again

start <- getwd()

test_that("logAccept accepts files in the QC log and returns expected errors", {
  
  setwd(demoRepo())
  
  path_to_qc_log <- file.path(logDir(),"QClog.csv")
  
  # logAccept file and confirm commit matches expected
  file1 <- "script/data-assembly.R"
  file2 <- "script/pk/load-spec.R"
  
  logAccept(file1)
  logAccept(file2)
  
  log <- logRead(path_to_qc_log)
  
  file1_commits <- log[log$file == file1, "commit"]
  expect_equal(gitLog(file1)[["commit"]], file1_commits[length(file1_commits)])
  
  file2_commits <- log[log$file == file2, "commit"]
  expect_equal(gitLog(file2)[["commit"]], file2_commits[length(file2_commits)])
  
  expect_error(logAccept(file1))
  
  new_file <- "script/examp-yaml.yaml"
  
  logAccept(new_file)
  log_upd <- logRead(path_to_qc_log)
  
  expect_equal(log_upd$commit[log_upd$file == new_file], gitLog(new_file)[["commit"]])
  expect_equal(log_upd$reviewer[log_upd$file == new_file], Sys.info()[["user"]])
})

setwd(start)
