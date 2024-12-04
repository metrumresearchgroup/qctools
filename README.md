# Getting Started with qctools

`qctools` is a toolkit for ensuring critical files are reviewed on a project. It manages the quality control (QC) process by tracking the assignment and acceptance of files using a centralized log file, **`QClog.csv`**. Along with tracking QC, `qctools` provides additional tooling for code review and comparing outputs such as figures and tables.

By integrating with Git, `qctools` automatically detects when a file has been modified and flags it for re-evaluation. It provides functions to check outstanding QC and summarize the QC status of all files.

The core functions of `qctools` are:

-   **`logCreate()`**: Creates the QC log.
-   **`logAssign()`**: Assigns files to reviewers for QC.
-   **`logAccept()`**: Marks files as reviewed and accepted.
-   **`logPending()`**: Lists files that still need QC.
-   **`logSummary()`**: Provides a high-level summary of the QC status of all files.

------------------------------------------------------------------------

# Core Functions

## `logCreate()`

To create a QC log, use `logCreate()`. This will generate the `QClog.csv` file at the top level of the project. 

``` r
library(qctools)
logCreate()
```

### Example Log (Pre-existing)

For demonstration, assume the `QClog.csv` already contains some entries.

| file               | commit             | reviewer   | datetime            |
|--------------------|--------------------|------------|---------------------|
| script/analysis.R  | Initial-Assignment | Jane Doe   | 2024-11-19 10:00:00 |
| script/data-prep.R | abc1234            | John Smith | 2024-11-19 11:30:00 |
| script/visualize.R | def5678            | Bob Miller | 2024-11-19 13:00:00 |

## `logAssign()`

Suppose we are the author of `script/model-fitting.R` and it is ready for review. We can assign `script/model-fitting.R` to `Alice Johnson` for QC.
Below is the code for this operation and the updated log.

``` r
logAssign(file = "script/model-fitting.R", reviewer = "Alice Johnson")
```

| file                                              | commit                                        | reviewer                                 | datetime                                       |
|---------------------|-----------------|-----------------|------------------|
| script/analysis.R                                 | Initial-Assignment                            | Jane Doe                                 | 2024-11-19 10:00:00                            |
| script/data-prep.R                                | abc1234                                       | John Smith                               | 2024-11-19 11:30:00                            |
| script/visualize.R                                | def5678                                       | Bob Miller                               | 2024-11-19 13:00:00                            |
| <b style='color:green'>script/model-fitting.R</b> | <b style='color:green'>Initial-Assignment</b> | <b style='color:green'>Alice Johnson</b> | <b style='color:green'>2024-11-19 14:00:00</b> |

## `logAccept()`

After `Alice Johnson` reviews `script/model-fitting.R`, she can accept the file by using `logAccept()`.

``` r
logAccept(file = "script/model-fitting.R")
```

| file                                              | commit                             | reviewer                                 | datetime                                       |
|---------------------|-----------------|-----------------|------------------|
| script/analysis.R                                 | Initial-Assignment                 | Jane Doe                                 | 2024-11-19 10:00:00                            |
| script/data-prep.R                                | abc1234                            | John Smith                               | 2024-11-19 11:30:00                            |
| script/visualize.R                                | def5678                            | Bob Miller                               | 2024-11-19 13:00:00                            |
| script/model-fitting.R                            | Initial-Assignment                 | Alice Johnson                            | 2024-11-19 14:00:00                            |
| <b style='color:green'>script/model-fitting.R</b> | <b style='color:green'>ghi9012</b> | <b style='color:green'>Alice Johnson</b> | <b style='color:green'>2024-11-19 15:00:00</b> |

## `logPending()`

Suppose we want to view all files with oustanding QC needs. `logPending()` lists files that require QC because they are either:

1.  Assigned but not yet reviewed.
2.  Modified since the last QC.

An example output of `logPending()` is shown below.

| file              | last_author | reviewer | datetime            |
|-------------------|-------------|----------|---------------------|
| script/analysis.R | Bob Miller  | Jane Doe | 2024-11-19 10:00:00 |

## `logSummary()`

If we want to see the QC status of all files in the log, we can use `logSummary()` to do so.


| file                   | status              |
|------------------------|---------------------|
| script/analysis.R      | Modified - needs QC |
| script/data-prep.R     | Fully QCed          |
| script/model-fitting.R | Fully QCed          |
| script/visualize.R     | Fully QCed          |

------------------------------------------------------------------------

# Workflow Example

1.  **Create the log (once per project)**: 

    ``` r
    logCreate()
    ```

2.  **Assign files for review**:

    ``` r
    logAssign(file = "script/model-fitting.R", reviewer = "Alice Johnson")
    ```

3.  **Mark files as accepted after review**:

    ``` r
    logAccept(file = "script/model-fitting.R")
    ```

4.  **Display files with oustanding QC**:

    ``` r
    logPending()
    ```

5.  **View the QC status of all files in the QC log**:

    ``` r
    logSummary()
    ```

------------------------------------------------------------------------

# Getting Help

If you encounter a clear bug, please file an issue with a minimal reproducible example on [the `qctools/issues` page](https://github.com/metrumresearchgroup/qctools/issues).
