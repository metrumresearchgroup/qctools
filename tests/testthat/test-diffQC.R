start <- getwd()

test_that("diffQC provides visual diff of files with differences", {
  
  setwd(demoRepo())
  
  x <- diffQC("script/data-assembly.R")
  
  expect_equal(length(x@target) + 5, length(x@current))
  expect_equal(x@tar.dat$orig[1], x@cur.dat$orig[1])
  
  y <- diffQC("script/pk/load-spec.R")
  
  expect_true(y@tar.dat$orig[1] != y@cur.dat$orig[1])
  
})

test_that("diffQC returns specified messages if no differences", {
  
  setwd(demoRepo())
  
  expect_error(diffQC("script/combine-da.R"), "File is up to date with QC")
  expect_error(diffQC("script/examp-txt.txt"), "script/examp-txt.txt not in QC log")
  
})

setwd(start)
