#' Get Git Repository History
#'
#' @description
#' Returns a data frame containing every commit made on the current branch.
#' The information recorded includes the commit hash, author, date, and
#' files changed in each commit.
#'
#' @keywords internal
repoHistory <- function() {
  
  log_dir <- logDir()
  
  # Get the git log with commit hash, author name, author date, and files changed
  git_log <- processx::run(
    "git",
    c(
      "-c",
      "core.quotePath=false",
      "log",
      "--name-only",                  # Show only names of files changed
      "--pretty=format:%H\t%an\t%ct", # Customize the log output format
      "--",
      "."
    ),
    wd = log_dir,
    echo = FALSE,
    error_on_status = TRUE
  )$stdout
  
  git_prefix <- processx::run(
    "git",
    c(
      "rev-parse",
      "--show-prefix"
    ),
    wd = log_dir,
    echo = FALSE,
    error_on_status = TRUE
  )$stdout
  
  # Split the output into lines
  log_lines <- strsplit(git_log, "\n")[[1]]
  log_lines <- log_lines[log_lines != ""]
  
  # Remove final new line
  git_prefix <- sub("\n$", "", git_prefix)
  
  commit_df <- 
    dplyr::tibble(log_lines = log_lines) %>%
    dplyr::mutate(
      is_header = grepl("\t", log_lines, fixed = TRUE),
      group = cumsum(is_header)
    ) %>%
    tidyr::separate(log_lines, into = c("sha", "author", "date"), sep = "\t", fill = "right", remove = FALSE) %>%
    dplyr::mutate(commit = ifelse(is_header, sha, NA_character_)) %>% 
    tidyr::fill(commit, author, date, .direction = "down") %>%
    dplyr::filter(!is_header) %>%
    dplyr::transmute(
      file = log_lines,
      author,
      date = as.POSIXct(as.integer(date), origin = "1970-01-01"),
      commit
    )
  
  if(!identical(git_prefix, "")){
    commit_df$file <- sub(paste0("^\\Q", git_prefix, "\\E"), "", commit_df$file)
  }
  
  commit_df
}
