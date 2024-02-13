start <- getwd()

test_that("diffQced provides visual diff of files with differences", {
  
  setwd(demoRepo())
  
  x <- diffQced("script/data-assembly.R")
  
  expect_equal(length(x@target) + 5, length(x@current))
  expect_equal(x@tar.dat$orig[1], x@cur.dat$orig[1])
  
  y <- diffQced("script/pk/load-spec.R")
  
  expect_true(y@tar.dat$orig[1] != y@cur.dat$orig[1])
  
})

test_that("diffQced returns specified messages if no differences", {
  
  setwd(demoRepo())
  
  expect_error(diffQced("script/combine-da.R"), "File is up to date with QC")
  expect_error(diffQced("script/examp-txt.txt"), "script/examp-txt.txt not in QC log")
  
})

setwd(start)
