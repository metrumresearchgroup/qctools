# qctools development

## New features and changes

- Exported functions brought over from the `review` package include: `logAssign()`,
  `logAccept()`, `logCreate()`, `logPending()`, `logSummary()`, `diffQced()` and
  `demoRepo()`. Each of these were modified slightly to account for the differences
  between SVN and Git.

- The contents of the `QClog.csv` file were updated. Commit hashes are now tracked
  in place of SVN revision numbers. The author of the file was also added to the
  QC log.

- A new function, `gitLog()`, was implemented to obtain information about the 
  commit where the last edit to a file was made. 

