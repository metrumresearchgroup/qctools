test_that("repoHistory returns all commits from every file", {
  
  with_demoRepo({
    
    repoH <- repoHistory()
    
    expect_true(all(names(repoH) == c("file", "author", "date", "commit")))
    expect_true(inherits(repoH, "data.frame"))
    expect_true(inherits(repoH$date, "POSIXct"))
    
    # Testing files based on how many commits are made in demoRepo script
    expect_true(nrow(repoH[repoH$file == "deliv/figure/example-pdf1.pdf",]) == 2)
    expect_true(nrow(repoH[repoH$file == "script/data-assembly.R",]) == 4)
    
    # Ensuring dates are always descending, newest rows first
    expect_true(repoH$date[1] > repoH$date[nrow(repoH)])
    expect_true(all(repoH$date - dplyr::lag(repoH$date, default = repoH$date[1]) <= 0))
    
  })
})
