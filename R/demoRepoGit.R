#' Create Demo Git Repo
#' 
#' @description 
#' Create a git repo with files checked in and a QC log. The purpose of this 
#' demo repo is for the user to become familiar with using review functions. 
#' 
#' The files checked into the repo are at various stages in terms of their QC
#' status. This function returns the path to the repo, so that the user can set
#' their working directory to it.
#'
#' This demo repo is created under the R session `/tmp/` directory, so a new one
#' will need to be generated whenever the user restarts R.
#' 
#' @param clean Logical indicating if the temporary directory should be deleted after use
#' 
#' @usage demoRepoGit(clean = TRUE)
#'
#' @export
demoRepoGit <- function(clean = TRUE) {
  
  repoInitPath <- withr::local_tempdir(
    "qctools-demo-",
    clean = clean, 
    .local_envir = parent.frame()
    )
  
  processx::run("git", c("init", repoInitPath, "--quiet"))
  
  withr::local_dir(repoInitPath)

  demoRepo_content1()
  
  processx::run("git", c("add", "."))
  processx::run("git", c("commit", "-m", "'initial commit'", "--quiet"))

  # Assign and accept scripts in QC log
  logAssign("script/data-assembly.R")
  logAssign("script/pk/load-spec.R")
  logAssign("script/combine-da.R")
  logAssign("script/examp-txt.txt")
  
  processx::run("git", c("add", "."))
  processx::run("git", c("commit", "-m", "'logAssign scripts ready for QC'", "--quiet"))
  
  logAccept("script/data-assembly.R")
  logAccept("script/pk/load-spec.R")
  logAccept("script/combine-da.R")
  
  # Check in updates to QC log
  processx::run("git", c("add", "."))
  processx::run("git", c("commit", "-m", "'logAccept scripts ready for QC'", "--quiet"))
  
  # Make edits to QCed file
  writeLines(
    c('pk_spec <- yspec::load_spec(here::here("script", "examp-yaml.yaml"))'),
    "script/pk/load-spec.R"
  )
  
  processx::run("git", c("add", "."))
  processx::run("git", c("commit", "-m", "'modify load-spec script'", "--quiet"))

  writeLines(
    c(
      "library(tidyverse)",
      'source(here::here("script", "data-assembly", "da-functions.R"))',
      'src_abc <- mrgda::read_src_dir(here::here("data", "source", "STUDY-ABC"))',
      "derived <- list(sl = list(),tv = list())",
      'dm_0 <- src_abc$dm %>% filter(ACTARM != "Screen Failure")',
      "derived$sl$dm <- dm_0",
      'pk_0 <- src_abc$pc %>% filter(PCTEST == "TEST OF INTEREST")',
      "derived$tv$pc <- pk_0",
      'ex_1 <- src_abc$ex %>% filter(EXTRT == "DRUG OF INTEREST")',
      "derived$tv$dosing <- ex_1"
    ),
    "script/data-assembly.R"
  )
  
  processx::run("git", c("add", "."))
  processx::run("git", c("commit", "-m", "'modify data-assembly'", "--quiet"))

  writeLines(
    c("The following tasks are suggested to gain familiarity with the review package:",
      '- run `diffQced()` on "script/pk/load-spec.R" and "script/data-assembly.R"',
      '- run `renderQCSummary()`',
      '- use `logAssign()` to add "script/examp-txt.txt" to the QC log',
      '- run `logPending()` to see what scripts are in need of QC',
      '- use `logAccept()` to sign off on any scripts with pending QC'),
    "README.md"
  )
  
  repoInitPath
}

#' @rdname demoRepoGit
#' 
#' @param code Executable code to run 
#' @export
with_demoRepoGit <- function(code, clean = TRUE) {
  repo <- demoRepoGit(clean)
  withr::with_dir(repo, code)
}