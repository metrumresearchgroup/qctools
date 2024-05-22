
<!-- README.md is generated from README.Rmd. Please edit that file -->
<!-- badges: start -->

[![Build
Status](https://github.com/metrumresearchgroup/qctools/actions/workflows/main.yaml/badge.svg)](https://github.com/metrumresearchgroup/qctools/actions/workflows/main.yaml)
<!-- badges: end -->

# qctools

*Note:* This package is still in an experimental stage of development
and backward incompatible changes may be made. Please see
[`NEWS.md`](https://github.com/metrumresearchgroup/qctools/blob/main/NEWS.md)
for details on any changes and updates.

## Overview

`qctools` provides helpful tools for organizing and performing quality
control (QC) tasks.

With `qctools`, you are able to create and manage a QC log to track the
QC history of all relevant files in your repository. While performing
QC, `diffQced()` will show all the changes to the file since it had last
been QCed.

## Setup

To start using `qctools`, run `logCreate()`. This will create the QC log
in the form of `QClog.csv`.

You can use `logAssign()` to add scripts needing QC to the QC log. After
completing QC, run `logAccept()`. This will add a row to the `QClog.csv`
recording the commit hash from the commit where the file was last
modified.

To identify which files need to be QCed, you can run `logPending()`. You
can also run `logSummary()` to see the QC status of all files in the
`QClog.csv` file.

## Documentation

Public documentation of all functions is hosted at
<https://metrumresearchgroup.github.io/qctools/>

## Development

`qctools` uses [pkgr](https://github.com/metrumresearchgroup/pkgr) to
manage development dependencies and
[renv](https://rstudio.github.io/renv/) to provide isolation. To
replicate this environment,

1.  clone the repo

2.  install pkgr

3.  open package in an R session and run `renv::init(bare = TRUE)`

    -   install `renv` \> 0.8.3-4 into default `.libPaths()` if not
        already installed

4.  run `pkgr install` in terminal within package directory

5.  restart session

Then, launch R with the repo as the working directory (open the project
in RStudio). renv will activate and find the project library.

## Getting help

If you encounter a clear bug, please file an issue with a minimal
reproducible example on [the `qctools/issues`
page](https://github.com/metrumresearchgroup/qctools/issues).
