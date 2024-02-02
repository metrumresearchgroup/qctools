start <- getwd()

testthat::test_that("demoRepo creates a git repo with expected files and version history", {
  
  repodir <- demoRepo()
  setwd(repodir)
  
  expect_true(inherits(repodir, "character"))
  expect_true(file.exists("QClog.csv"))
  
  log <- logRead("QClog.csv")
  
  expect_equal(nrow(log), 7)
  expect_equal(nrow(log[log$file == "script/data-assembly.R",]), 2)
  expect_true(any(log$commit == "Initial-Assignment"))
  
})

setwd(start)
