test_that("logCreate generates a QC log csv file with expected columns", {
  
  with_demoRepoGit({
    
    file.remove("QClog.csv")
    
    logCreate()
    
    path_to_qc_log <- file.path(logDir(), "QClog.csv")
    expect_true(file.exists(path_to_qc_log))
    
    col_headers <- readLines(path_to_qc_log)
    expect_equal("file,commit,reviewer,datetime", col_headers)
    
    expect_error(logCreate())
  })
})

test_that("logCreate works when multiple Rproj files present", {
  
  with_demoRepoGit({
    fs::dir_create("subdir")
    setwd("subdir")
    writeLines("Version: 1.0", con = "temp2.Rproj")
    logCreate()
    
    expect_true(file.exists("QClog.csv"))
  })
  
})
