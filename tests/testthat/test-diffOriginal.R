test_that("diffOriginal provides visual diff of files with differences", {
  
  with_demoRepo({
    x <- diffOriginal("script/data-assembly.R")
    
    expect_equal(length(x@target) + 5, length(x@current))
    expect_equal(x@tar.dat$orig[1], x@cur.dat$orig[1])
    
    y <- diffOriginal("script/pk/load-spec.R")
    
    expect_true(y@tar.dat$orig[1] != y@cur.dat$orig[1])
  })
})

test_that("diffOriginal works with subdirectories", {
  
  with_demoRepo({
    
    # Create subdirectory
    fs::dir_create("subdir")
    setwd("subdir")
    
    # Add QC log & Rproj file
    writeLines("Version: 1.0", con = "temp2.Rproj")
    logCreate()
    
    # Create script directory
    fs::dir_create("script")
    writeLines("Example text", con = "script/subdir2.txt")
    
    # Check in new files to git
    processx::run("git", c("add", "."))
    processx::run("git", c("commit", "-m", "'add subdir'", "--quiet"))
    logAccept("script/subdir2.txt")
    
    writeLines("New text", con = "script/subdir2.txt")
    
    processx::run("git", c("add", "."))
    processx::run("git", c("commit", "-m", "'add subdir'", "--quiet"))
    
    # Check diff is possible while inside subdirectory
    diff_sub <- diffOriginal("script/subdir2.txt")
    
    expect_true(diff_sub@target == "Example text")
    expect_true(diff_sub@current == "New text")
  })
})
