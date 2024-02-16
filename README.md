## Overview

mrgqc provides helpful tools for organizing and performing quality control (QC)
tasks.

With mrgqc, you are able to create and manage a QC log to track the QC history
of all relevant files in your repository. While performing QC, `diffQced()` will
show all the changes to the file since it had last been QCed.

Note: This package is still in an experimental stage of development and backward 
incompatible changes may be made. Please see NEWS.md for details on any changes and updates.

## Setup

To start using mrgqc, run `logCreate()`. This will create the QC log in the form
of `QClog.csv`. 

You can use `logAssign()` to add scripts needing QC to the QC log. After
completing QC, run `logAccept()`. This will add a row to the `QClog.csv` recording
the commit hash from the commit where the file was last modified.

To identify which files need to be QCed, you can run `logPending()`. You can also
run `logSummary()` to see the QC status of all files in the `QClog.csv` file.

## Documentation
Public documentation of all functions is hosted at [https://metrumresearchgroup.github.io/mrgqc/](https://metrumresearchgroup.github.io/mrgqc/)

## Development

`mrgqc` uses [pkgr](https://github.com/metrumresearchgroup/pkgr) to manage
development dependencies and [renv](https://rstudio.github.io/renv/) to
provide isolation. To replicate this environment,

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

If you encounter a clear bug, please file an issue with a minimal reproducible example on [mrgqc](https://github.com/metrumresearchgroup/mrgqc/issues). 