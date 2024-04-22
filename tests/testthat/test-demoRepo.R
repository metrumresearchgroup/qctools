testthat::test_that("demoRepo creates a git repo with expected files and version history", {
  
  with_demoRepoGit({
    expect_true(file.exists("QClog.csv"))
    
    log <- logRead("QClog.csv")
    
    expect_equal(nrow(log), 7)
    expect_equal(nrow(log[log$file == "script/data-assembly.R",]), 2)
    expect_true(any(log$commit == "Initial-Assignment"))
    
  })
})

testthat::test_that("demoRepoGit returns character path to temp repo", {
  expect_true(inherits(demoRepoGit(), "character"))
})

testthat::test_that("demoRepoSVN creates a svn repo with expected files and version history", {
  
  with_demoRepoSVN({
    expect_true(file.exists("QClog.csv"))
    
    log <- logRead("QClog.csv")
    
    expect_equal(nrow(log), 7)
    expect_equal(nrow(log[log$file == "script/data-assembly.R",]), 2)
    expect_true(any(log$commit == "Initial-Assignment"))
    
  })
})