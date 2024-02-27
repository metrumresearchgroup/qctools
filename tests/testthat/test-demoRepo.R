testthat::test_that("demoRepo creates a git repo with expected files and version history", {
  
  with_demoRepo({
    expect_true(file.exists("QClog.csv"))
    
    log <- logRead("QClog.csv")
    
    expect_equal(nrow(log), 7)
    expect_equal(nrow(log[log$file == "script/data-assembly.R",]), 2)
    expect_true(any(log$commit == "Initial-Assignment"))
    
  })
})

testthat::test_that("demoRepo returns character path to temp repo", {
  expect_true(inherits(demoRepo(), "character"))
})