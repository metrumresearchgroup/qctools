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

test_that("repoHistory works wit a project in a sub directory of the git repo", {
  
  with_demoRepo({
    
    dir.create("sub-project")
    setwd("sub-project")
    writeLines("Version: 1.0", "sub-project.Rproj")
    writeLines("test", "output.txt")
    
    processx::run("git", c("add", "."))
    processx::run("git", c("commit", "-m", "'dummy file'", "--quiet"))
    
    repoH <- repoHistory()
    
    expect_true(all(names(repoH) == c("file", "author", "date", "commit")))
    expect_true(inherits(repoH, "data.frame"))
    expect_true(inherits(repoH$date, "POSIXct"))
    
    # Ensure extra path to git repo is removed
    expect_true(nrow(repoH[repoH$file == "output.txt",]) == 1)
    # Ensure its just the new file and the new project file
    expect_true(nrow(repoH) == 2)
    
  })

})
