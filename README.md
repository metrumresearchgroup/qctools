# Getting Started with qctools

`qctools` is a toolkit for managing the quality control (QC) process for scripts. It tracks the assignment, review, and acceptance of scripts using a centralized log file, **`QClog.csv`**. This log ensures that every script is reviewed systematically, with clear records of modifications and approvals.

By integrating with Git, `qctools` automatically detects when a script has been modified and flags it for re-evaluation. It provides functions to assign reviewers, check pending work, and summarize the QC status of all scripts.

The core functions of `qctools` are:

- **`logCreate()`**: Creates the QC log.
- **`logAssign()`**: Assigns scripts to reviewers for QC.
- **`logAccept()`**: Marks scripts as reviewed and accepted.
- **`logPending()`**: Lists scripts that still need QC.
- **`logSummary()`**: Provides a high-level summary of the QC status of all scripts.

---

# Core Functions

## `logCreate()`

The first step is to create the QC log file using `logCreate()`:

```r
library(qctools)
logCreate()
```

## Example Log (Pre-existing)

For demonstration, assume the `QClog.csv` already contains some entries. Below is the initial log:

| file               | commit             | reviewer    | datetime            |
|--------------------|--------------------|-------------|---------------------|
| script/analysis.R  | Initial-Assignment | Jane Doe    | 2024-11-19 10:00:00 |
| script/data-prep.R | abc1234            | John Smith  | 2024-11-19 11:30:00 |
| script/visualize.R | def5678            | Bob Miller  | 2024-11-19 13:00:00 |

## `logAssign()`

Assigns a file for QC, optionally specifying a reviewer.

### Example

Suppose we assign `script/model-fitting.R` to `Alice Johnson` for QC. Below is the code for this operation and the updated log:

```r
logAssign(file = "script/model-fitting.R", reviewer = "Alice Johnson")
```

| file                   | commit             | reviewer      | datetime            |
|------------------------|--------------------|---------------|---------------------|
| script/analysis.R      | Initial-Assignment | Jane Doe      | 2024-11-19 10:00:00 |
| script/data-prep.R     | abc1234            | John Smith    | 2024-11-19 11:30:00 |
| script/visualize.R     | def5678            | Bob Miller    | 2024-11-19 13:00:00 |
| <b style='color:green'>script/model-fitting.R</b> | <b style='color:green'>Initial-Assignment</b> | <b style='color:green'>Alice Johnson</b> | <b style='color:green'>2024-11-19 14:00:00</b> |

## `logAccept()`

Marks a file as accepted after review, recording the latest commit and reviewer details. The new row for acceptance will appear alongside the assigned row.

### Example

Suppose `script/model-fitting.R` is reviewed and accepted by `Alice Johnson`. The log now reflects both the assignment and the acceptance:

```r
logAccept(file = "script/model-fitting.R")
```

| file                   | commit             | reviewer      | datetime            |
|------------------------|--------------------|---------------|---------------------|
| script/analysis.R      | Initial-Assignment | Jane Doe      | 2024-11-19 10:00:00 |
| script/data-prep.R     | abc1234            | John Smith    | 2024-11-19 11:30:00 |
| script/visualize.R     | def5678            | Bob Miller    | 2024-11-19 13:00:00 |
| script/model-fitting.R | Initial-Assignment | Alice Johnson | 2024-11-19 14:00:00 |
| <b style='color:green'>script/model-fitting.R</b> | <b style='color:green'>def5678</b>            | <b style='color:green'>Alice Johnson</b> | <b style='color:green'>2024-11-19 15:00:00</b> |

## `logPending()`

Lists files that require QC because they are either:

1. Assigned but not yet reviewed.
2. Modified since the last QC.

### Example

Here are the files still pending QC:

| file              | last_author | reviewer   | datetime            |
|-------------------|-------------|------------|---------------------|
| script/analysis.R | Bob Miller  | Jane Doe   | 2024-11-19 10:00:00 |

## `logSummary()`

Provides a summary of the QC status of all files in the log.

### Example

Here is the summary of the QC status:

| file                | status                 |
|---------------------|------------------------|
| script/analysis.R   | Modified - needs QC    |
| script/data-prep.R  | Fully QCed             |
| script/model-fitting.R | Fully QCed          |
| script/visualize.R  | Fully QCed             |

---

# Workflow Example

1. **Create the log**:

   ```r
   logCreate()
   ```

2. **Assign files for review**:

   ```r
   logAssign(file = "script/model-fitting.R", reviewer = "Alice Johnson")
   ```

3. **Mark files as accepted after review**:

   ```r
   logAccept(file = "script/model-fitting.R")
   ```

4. **Check pending files**:

   ```r
   logPending()
   ```

5. **View a summary of the QC process**:

   ```r
   logSummary()
   ```
   
---

# Getting Help

If you encounter a clear bug, please file an issue with a minimal reproducible example on [the `qctools/issues` page](https://github.com/metrumresearchgroup/qctools/issues).