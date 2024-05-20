file1 <- "script/data-assembly.R"
file2 <- "script/pk/load-spec.R"

test_that("gitLog returns the commit the file was last modified", {
  
  with_demoRepo({
    
    gitFile1 <- gitLog(file1, last_rev_only = TRUE)
    gitFile2 <- gitLog(file2, last_rev_only = TRUE)
    
    expect_true(nrow(gitFile1) == 1)
    expect_true(nrow(gitFile2) == 1)
    expect_equal(length(names(gitFile1)), 4)
    expect_true("file" %in% names(gitFile1))
    expect_true("last_commit" %in% names(gitFile1))
    expect_true("last_author" %in% names(gitFile1))
    expect_true("last_datetime" %in% names(gitFile1))
    
    files <- c("script/combine-da.R", "script/data-assembly.R", "script/examp-txt.txt")
    gitFiles <- gitLog(files, last_rev_only = TRUE)
    
    expect_true(nrow(gitFiles) == 3)
    expect_true(gitFiles[gitFiles$file == "script/combine-da.R", "last_commit"] != 
                  gitFiles[gitFiles$file == "script/data-assembly.R", "last_commit"])
    
    setwd("script")
    
    gitFile3 <- gitLog("examp-yaml.yaml")
    expect_equal(nchar(gitFile3$last_commit), 40)
    
  })
})

test_that("gitLog returns all commits for a file", {
  with_demoRepo({
    
    gitFile1 <- gitLog(file1)
    gitFile2 <- gitLog(file2)
    
    expect_true(nrow(gitFile1) == 2)
    expect_true(nrow(gitFile2) == 2)
  })
})