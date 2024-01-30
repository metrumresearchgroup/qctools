# mrgqc

## Developer notes 

- `logCreate()` now only uses 2 internal functions`logDir()` & `logWrite()` which is used for 
   both log creation and modifying so it makes sense to keep as its own function. 
-  Now using `here::here()`, which should remove the need for `logRoot()`, `logName()` and `absDir()`
- `logAssign()` and `logAccept()` should need to run very similar code to do file and log checks.
   Creating `logEdit()` which both of them will wrap, inputting specific arguments for `commit` and
   `reviewer`.