# Test if the dataset meets the many packages universe requirements

# Report missing values
test_that("missing observations are reported correctly", {
  expect_false(any(grepl("^n/a$", contiguity[["DIRCONT"]])))
  expect_false(any(grepl("^N/A$", contiguity[["DIRCONT"]])))
  expect_false(any(grepl("^\\s$", contiguity[["DIRCONT"]])))
  expect_false(any(grepl("^\\.$", contiguity[["DIRCONT"]])))
  expect_false(any(grepl("N\\.A\\.$", contiguity[["DIRCONT"]])))
  expect_false(any(grepl("n\\.a\\.$", contiguity[["DIRCONT"]])))
})

# Date columns should be in mdate class
test_that("Columns are not in date, POSIXct or POSIXlt class", {
  expect_false(any(lubridate::is.Date(contiguity[["DIRCONT"]])))
  expect_false(any(lubridate::is.POSIXct(contiguity[["DIRCONT"]])))
  expect_false(any(lubridate::is.POSIXlt(contiguity[["DIRCONT"]])))
})
