file1 <- "script/data-assembly.R"
file2 <- "script/pk/load-spec.R"

test_that("vcsLastCommit returns the commit the file was last modified", {
  
  with_demoRepo({
    
    gitFile1 <- vcsLastCommit(file1)
    gitFile2 <- vcsLastCommit(file2)
    
    expect_true(nrow(gitFile1) == 1)
    expect_true(nrow(gitFile2) == 1)
    expect_equal(length(names(gitFile1)), 4)
    expect_true("file" %in% names(gitFile1))
    expect_true("last_commit" %in% names(gitFile1))
    expect_true("last_author" %in% names(gitFile1))
    expect_true("last_datetime" %in% names(gitFile1))
    
    files <- c("script/combine-da.R", "script/data-assembly.R", "script/examp-txt.txt")
    gitFiles <- vcsLastCommit(files)
    
    expect_true(nrow(gitFiles) == 3)
    expect_true(gitFiles[gitFiles$file == "script/combine-da.R", "last_commit"] != 
                  gitFiles[gitFiles$file == "script/data-assembly.R", "last_commit"])
    
    setwd("script")
    
    gitFile3 <- vcsLastCommit("examp-yaml.yaml")
    expect_equal(nchar(gitFile3$last_commit), 40)
    
  })
})

test_that("vcsLastCommit returns the commit the file was last modified", {
  
  with_demoRepoSVN({
    
    svnFile1 <- vcsLastCommit(file1)
    svnFile2 <- vcsLastCommit(file2)
    
    expect_true(nrow(svnFile1) == 1)
    expect_true(nrow(svnFile2) == 1)
    expect_equal(length(names(svnFile1)), 4)
    expect_true("file" %in% names(svnFile1))
    expect_true("last_commit" %in% names(svnFile1))
    expect_true("last_author" %in% names(svnFile1))
    expect_true("last_datetime" %in% names(svnFile1))
    
    files <- c("script/combine-da.R", "script/data-assembly.R", "script/examp-txt.txt")
    svnFiles <- vcsLastCommit(files)
    
    expect_true(nrow(svnFiles) == 3)
    expect_true(svnFiles[svnFiles$file == "script/combine-da.R", "last_commit"] != 
                  svnFiles[svnFiles$file == "script/data-assembly.R", "last_commit"])
    
    setwd("script")
    
    svnFile3 <- vcsLastCommit("examp-yaml.yaml")
    expect_equal(nchar(svnFile3$last_commit), 1)
    
  })
})
