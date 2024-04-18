file1 <- "script/data-assembly.R"
file2 <- "script/pk/load-spec.R"

test_that("logAccept accepts files in the QC log and returns expected errors", {
  
  with_demoRepoGit({
    
    path_to_qc_log <- file.path(logDir(),"QClog.csv")
    
    logAccept(file1)
    logAccept(file2)
    
    log <- logRead(path_to_qc_log)
    
    file1_commits <- log[log$file == file1, "commit"]
    expect_equal(vcsLastCommit(file1)[["last_commit"]], file1_commits[length(file1_commits)])
    
    file2_commits <- log[log$file == file2, "commit"]
    expect_equal(vcsLastCommit(file2)[["last_commit"]], file2_commits[length(file2_commits)])
    
    expect_error(logAccept(file1))
    
    new_file <- "script/examp-yaml.yaml"
    
    logAccept(new_file)
    log_upd <- logRead(path_to_qc_log)
    
    expect_equal(log_upd$commit[log_upd$file == new_file], vcsLastCommit(new_file)[["last_commit"]])
    expect_equal(log_upd$reviewer[log_upd$file == new_file], Sys.info()[["user"]])
  })
})

test_that("logAccept accepts files in the QC log and returns expected errors within SVN", {
  
  with_demoRepoSVN({
    
    path_to_qc_log <- file.path(logDir(),"QClog.csv")
    
    logAccept(file1)
    logAccept(file2)
    
    log <- logRead(path_to_qc_log)
    
    file1_commits <- log[log$file == file1, "commit"]
    expect_equal(vcsLastCommit(file1)[["last_commit"]], file1_commits[length(file1_commits)])
    
    file2_commits <- log[log$file == file2, "commit"]
    expect_equal(vcsLastCommit(file2)[["last_commit"]], file2_commits[length(file2_commits)])
    
    expect_error(logAccept(file1))
    
    new_file <- "script/examp-yaml.yaml"
    
    logAccept(new_file)
    log_upd <- logRead(path_to_qc_log)
    
    expect_equal(log_upd$commit[log_upd$file == new_file], vcsLastCommit(new_file)[["last_commit"]])
    expect_equal(log_upd$reviewer[log_upd$file == new_file], Sys.info()[["user"]])
  })
})
