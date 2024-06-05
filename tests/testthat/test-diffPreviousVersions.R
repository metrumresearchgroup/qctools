with_demoRepo({
  file1 <- "script/data-assembly.R"
  file2 <- "script/pk/load-spec.R"
  
  file1_ver1 <- gitLog(file1)[1,][["last_commit"]]
  file1_ver2 <- gitLog(file1)[2,][["last_commit"]]
  
  file2_ver1 <- gitLog(file2)[2,][["last_commit"]]
  
  test_that("diffPreviousRevisions outputs diff between two previous specified versions", {
    diffVer <- diffPreviousVersions(file = file1, previous_version = file1_ver2, current_version = file1_ver1)
    expect_true(length(diffVer@target) + 1 == length(diffVer@current))
    expect_true(diffVer@target[2] == diffVer@current[2])
    expect_equal(diffVer@current[2], "source(here::here(\"script\", \"data-assembly\", \"da-functions.R\"))")
    expect_equal(diffVer@target[1], diffVer@current[1])
    expect_equal(diffVer@current[10], "derived$tv$dosing <- ex_1")
  })
  
  test_that("diffPreviousRevisions defaults current version of diff to local version", {
    diffVer <- diffPreviousVersions(file = file2, previous_version = file2_ver1)
    expect_true(diffVer@target != diffVer@current)
    expect_equal(diffVer@target, "pk_spec <- yspec::load_spec(here::here(\"script\", \"script/examp-yaml.yaml\"))")
    expect_equal(diffVer@current, "pk_spec <- yspec::load_spec(here::here(\"script\", \"examp-yaml.yaml\"))")
  })
})
