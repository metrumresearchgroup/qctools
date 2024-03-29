% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/demoRepo.R
\name{demoRepo}
\alias{demoRepo}
\alias{with_demoRepo}
\title{Create Demo Git Repo}
\usage{
demoRepo(clean = TRUE)

with_demoRepo(code, clean = TRUE)
}
\arguments{
\item{clean}{Logical indicating if the temporary directory should be deleted after use}

\item{code}{Executable code to run}
}
\description{
Create a git repo with files checked in and a QC log. The purpose of this
demo repo is for the user to become familiar with using review functions.

The files checked into the repo are at various stages in terms of their QC
status. This function returns the path to the repo, so that the user can set
their working directory to it.

This demo repo is created under the R session \verb{/tmp/} directory, so a new one
will need to be generated whenever the user restarts R.
}
