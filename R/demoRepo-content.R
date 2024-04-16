#' @keywords internal
demoRepo_content1 <- function() {
  writeLines("Version: 1.0", con = "temp.Rproj")
  
  # Add scripts to the repo
  fs::dir_create("script/pk", recurse = TRUE)
  fs::dir_create("deliv/figure")
  fs::dir_create("deliv/table")
  
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
  
  writeLines(c("This is the first version of the yml file"),
             "pkgr.yml")
  
  # Create QC log
  logCreate()
}