test_that("diffFiles provides visual diff of two files", {
  
  with_demoRepo({
    x <- diffFiles("script/data-assembly.R", "script/combine-da.R")
    
    expect_true(all(x@current == readLines("script/combine-da.R")))
    expect_true(all(x@target == readLines("script/data-assembly.R")))
    expect_equal(length(x@target), 10)
  })
})

test_that("diffFiles works when no differences", {
  
  with_demoRepo({
    y <- diffFiles("script/combine-da.R", "script/combine-da.R")
    expect_true(all(y@trim.dat$diffs == 0))
  })
})

test_that("diffFiles works with subdirectories", {
  
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
    writeLines("Other text", con = "script/subdir3.txt")
    
    diff1 <- diffFiles("script/subdir2.txt", "script/subdir3.txt")
    
    expect_equal(diff1@current, "Other text")
    expect_equal(diff1@target, "Example text")
  })
})
