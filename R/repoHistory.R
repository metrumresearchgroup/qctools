#' Get Git Repository History
#'
#' @description
#' Returns a data frame containing every commit made to the Git repository.
#' The information recorded includes the commit hash, author, date, and
#' files changed in each commit.
#'
#' @keywords internal
repoHistory <- function() {
  # Get the git log with commit hash, author name, author date, and files changed
  git_log <- processx::run(
    "git",
    c(
      "--literal-pathspecs",          # Treat pathspecs literally
      "log",
      "--name-only",                  # Show only names of files changed
      "--pretty=format:%H\t%an\t%ad", # Customize the log output format
      "--date=format:%Y-%m-%d %H:%M:%S %z" # Specify date format
    ),
    wd = logDir(),
    echo = FALSE,
    error_on_status = TRUE
  )$stdout
  
  # Split the output into lines
  log_lines <- strsplit(git_log, "\n")[[1]]
  log_lines <- log_lines[log_lines != ""]
  
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
      date = as.POSIXct(date, format = "%Y-%m-%d %H:%M:%S %z"),
      commit
    )
  
  commit_df
}
