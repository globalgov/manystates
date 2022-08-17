# Test if the dataset meets the many packages universe requirements

# Report missing values
test_that("missing observations are reported correctly", {
  expect_false(any(grepl("^n/a$", contiguity[["GNEVAR_CONT"]])))
  expect_false(any(grepl("^N/A$", contiguity[["GNEVAR_CONT"]])))
  expect_false(any(grepl("^\\s$", contiguity[["GNEVAR_CONT"]])))
  expect_false(any(grepl("^\\.$", contiguity[["GNEVAR_CONT"]])))
  expect_false(any(grepl("N\\.A\\.$", contiguity[["GNEVAR_CONT"]])))
  expect_false(any(grepl("n\\.a\\.$", contiguity[["GNEVAR_CONT"]])))
})

# Date columns should be in mdate class
test_that("Columns are not in date, POSIXct or POSIXlt class", {
  expect_false(any(lubridate::is.Date(contiguity[["GNEVAR_CONT"]])))
  expect_false(any(lubridate::is.POSIXct(contiguity[["GNEVAR_CONT"]])))
  expect_false(any(lubridate::is.POSIXlt(contiguity[["GNEVAR_CONT"]])))
})
