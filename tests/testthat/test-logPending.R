test_that("logPending accepts files in the QC log and returns expected errors", {
  
  with_demoRepo({
    
    path_to_qc_log <- file.path(logDir(),"QClog.csv")
    
    log <- logCheckRead()
    pending <- logPending()
    
    file1 <- "script/data-assembly.R"
    file2 <- "script/pk/load-spec.R"
    file3 <- "script/combine-da.R"
    file4 <- "script/examp-txt.txt"
    
    if (!gitLog(file1)[["commit"]] %in% log[log$file == file1, "commit"]) {
      expect_true(file1 %in% pending$file)
    }
    
    if (!gitLog(file2)[["commit"]] %in% log[log$file == file2, "commit"]) {
      expect_true(file2 %in% pending$file)
    }
    
    if (gitLog(file3)[["commit"]] %in% log[log$file == file3, "commit"]) {
      expect_true(!file3 %in% pending$file)
    }
    
    if (!gitLog(file4)[["commit"]] %in% log[log$file == file4, "commit"]) {
      expect_true(file4 %in% pending$file)
    }
    
  })
})
