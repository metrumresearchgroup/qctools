start <- getwd()

test_that("gitLog returns the commit the file was last modified", {
  
  setwd(demoRepo())
  
  file1 <- "script/data-assembly.R"
  file2 <- "script/pk/load-spec.R"
  
  gitFile1 <- gitLog(file1)
  gitFile2 <- gitLog(file2)
  
  expect_true(length(gitLog(file1)) == 3)
  expect_true("commit" %in% names(gitFile1))
  expect_true("author" %in% names(gitFile1))
  expect_true("datetime" %in% names(gitFile1))
  
  sysFile1 <- processx::run("git", c("log", "--format=%H%x09%an%x09%aI%x09", "-n1", "--", file1))
  sysFile1_unlist <- unlist(strsplit(sysFile1$stdout, split = "\t"))
  
  expect_equal(gitFile1$commit, sysFile1_unlist[1])
  
})

setwd(start)
