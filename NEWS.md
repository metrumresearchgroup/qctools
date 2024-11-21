# qctools development

## New features and changes

- `repoHistory` added to return all commits made to every file. (#32)

# qctools 0.2.1

## Bug fixes

- `getModified` updated to only grab last commit when calling `gitLog`. (#26)

# qctools 0.2.0

## New features and changes

- `gitLog` updated to return the full history of commits for a file. (#21)

- `diffOriginal` added to the package to view the difference between the current 
   and first version of a file. (#22)

- `diff` functions carried over from the `review` package. (#22)

- `compare` functions brought over from the `review` package, including `compareFigures()` 
  and `compareTables()`. (#23)

# qctools 0.1.0

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

