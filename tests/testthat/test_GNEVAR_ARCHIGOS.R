# Test if the dataset meets the many packages universe requirements

# Report missing values
test_that("missing observations are reported correctly", {
  expect_false(any(grepl("^n/a$", leaders[["GNEVAR_ARCHIGOS"]])))
  expect_false(any(grepl("^N/A$", leaders[["GNEVAR_ARCHIGOS"]])))
  expect_false(any(grepl("^\\s$", leaders[["GNEVAR_ARCHIGOS"]])))
  expect_false(any(grepl("^\\.$", leaders[["GNEVAR_ARCHIGOS"]])))
  expect_false(any(grepl("N\\.A\\.$", leaders[["GNEVAR_ARCHIGOS"]])))
  expect_false(any(grepl("n\\.a\\.$", leaders[["GNEVAR_ARCHIGOS"]])))
})

# Date columns should be in mdate class
test_that("Columns are not in date, POSIXct or POSIXlt class", {
  expect_false(any(lubridate::is.Date(leaders[["GNEVAR_ARCHIGOS"]])))
  expect_false(any(lubridate::is.POSIXct(leaders[["GNEVAR_ARCHIGOS"]])))
  expect_false(any(lubridate::is.POSIXlt(leaders[["GNEVAR_ARCHIGOS"]])))
})
