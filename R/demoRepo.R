#' Create Demo Git Repo
#' 
#' @description 
#' Create a Github repo with files checked in and a QC log. The purpose of this 
#' demo repo is for the user to become familiar with using review functions. 
#' 
#' The files checked into the repo are at various stages in terms of their QC
#' needs. This function returns the path to the repo, so that the user can set
#' their working directory to it. 
#' 
#' This demo repo is created in the `tmp` folder, so a new one will need to be
#' generated whenever the user restarts R. 
#'
#' @export
demoRepo <- function() {
  
  curDir <- getwd()
  on.exit(setwd(curDir))
  
  repoInitPath <- fs::path_temp()
  
  if (fs::dir_exists(repoInitPath)) {
    fs::dir_delete(repoInitPath)
  }
  
  # Create svn repo at specified locations
  system(glue::glue("git init {repoInitPath} --quiet"))
  
  setwd(repoInitPath)
  rstudioapi::initializeProject()
  
  # Add scripts to the repo
  fs::dir_create("script/pk", recurse = TRUE)
  
  writeLines(
    c(
      "library(tidyverse)",
      'src_abc <- mrgda::read_src_dir(here::here("data", "source", "STUDY-ABC"))',
      "derived <- list(sl = list(),tv = list())",
      'dm_0 <- src_abc$dm %>% filter(ACTARM != "Screen Failure")',
      "derived$sl$dm <- dm_0"
    ),
    "script/data-assembly.R"
  )
  
  writeLines(
    c(
      "library(tidyverse)",
      "studies <- list()",
      'studies$pk_abc <- readr::read_rds(here::here("data", "derived", "studies", "pk-abc.rds"))',
      "pk_0 <- bind_rows(studies) %>% arrange(USUBJID, DATETIME)",
      'pk_1 <- pk_0 %>% mrgda::assign_id(., "USUBJID")',
      "pk_out <- pk_1"
    ),
    "script/combine-da.R"
  )
  
  writeLines(
    c(
      'pk_spec <- yspec::load_spec(here::here("script", "script/examp-yaml.yaml"))'
    ),
    "script/pk/load-spec.R"
  )
  
  writeLines(c('This is the first version of the txt file'),
             "script/examp-txt.txt")
  
  writeLines(c("This is the first version of the yaml file"),
             "script/examp-yaml.yaml")
  
  # Create QC log
  logCreate()
  
  # Check everything into SVN
  system("git add *")
  system(glue::glue("git commit -m 'initial commit' --quiet"))
  
  # Assign and accept scripts in QC log
  logAssign("script/data-assembly.R")
  logAssign("script/pk/load-spec.R")
  logAssign("script/combine-da.R")
  logAssign("script/examp-txt.txt")
  
  system("git add *")
  system(glue::glue("git commit -m 'logAssign scripts ready for QC' --quiet"))
  
  logAccept("script/data-assembly.R")
  logAccept("script/pk/load-spec.R")
  logAccept("script/combine-da.R")
  
  # Check in updates to QC log
  system("git add *")
  system(glue::glue("git commit -m 'logAccept scripts ready for QC' --quiet"))
  
  # Make edits to QCed file
  writeLines(
    c('pk_spec <- yspec::load_spec(here::here("script", "examp-yaml.yaml"))'),
    "script/pk/load-spec.R"
  )
  
  system("git add *")
  system(glue::glue("git commit -m 'modify load-spec script' --quiet"))

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
  
  system("git add *")
  system(glue::glue("git commit -m 'modify data-assembly' --quiet"))

  writeLines(
    c("The following tasks are suggested to gain familiarity with the review package:",
      '- run `diffQCed()` on "script/pk/load-spec.R" and "script/data-assembly.R"',
      '- run `renderQCSummary()`',
      '- use `logAssign()` to add "script/examp-txt.txt" to the QC log',
      '- run `logPending()` to see what scripts are in need of QC',
      '- use `logAccept()` to sign off on any scripts with pending QC'),
    "README.md"
  )
  
  repoInitPath
}