# mrgqc

## Developer notes 

- `logCreate()` now is only reliant on `logWrite()` and `absDir()` to run. `logWrite()` used for both log creation
   and modifying so it makes sense to keep as its own function. 
- `logCreate()` did use `logRoot()` and `logName()` prior, however this doesn't seem necessary or
   beneficial (for now). Thinking if this is the same for other functions, these could be removed.