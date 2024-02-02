start <- getwd()

test_that("logPending accepts files in the QC log and returns expected errors", {
  
  setwd(demoRepo())
  
  path_to_qc_log <- file.path(logDir(),"QClog.csv")
  
  log <- logRead(path_to_qc_log)
  summary <- logSummary()
  
  expect_true(nrow(summary) == length(summary$file))
  expect_true(length(unique(summary$status)) == 3)
  
  file1 <- "script/data-assembly.R"
  file2 <- "script/pk/load-spec.R"
  file3 <- "script/combine-da.R"
  file4 <- "script/examp-txt.txt"
  
  expect_equal(summary[summary$file == file1, "status"], "Modified, needs QC")
  expect_equal(summary[summary$file == file2, "status"], "Modified, needs QC")
  expect_equal(summary[summary$file == file3, "status"], "Fully QCed")
  expect_equal(summary[summary$file == file4, "status"], "Assigned, needs QC")
  
})

setwd(start)

