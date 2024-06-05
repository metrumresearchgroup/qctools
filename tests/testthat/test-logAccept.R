file1 <- "script/data-assembly.R"
file2 <- "script/pk/load-spec.R"

test_that("logAccept accepts files in the QC log and returns expected errors", {
  
  with_demoRepo({
    
    path_to_qc_log <- file.path(logDir(),"QClog.csv")
    
    logAccept(file1)
    logAccept(file2)
    
    log <- logRead(path_to_qc_log)
    
    file1_commits <- log[log$file == file1, "commit"]
    expect_equal(gitLog(file1, last_rev_only = TRUE)[["last_commit"]], file1_commits[length(file1_commits)])
    
    file2_commits <- log[log$file == file2, "commit"]
    expect_equal(gitLog(file2, last_rev_only = TRUE)[["last_commit"]], file2_commits[length(file2_commits)])
    
    expect_error(logAccept(file1))
    
    new_file <- "script/examp-yaml.yaml"
    
    logAccept(new_file)
    log_upd <- logRead(path_to_qc_log)
    
    expect_equal(sort(log_upd$commit[log_upd$file == new_file]), sort(gitLog(new_file)[["last_commit"]]))
    expect_equal(unique(log_upd$reviewer[log_upd$file == new_file]), Sys.info()[["user"]])
  })
})
