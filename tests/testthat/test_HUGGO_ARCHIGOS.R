# Test if the dataset meets the many packages universe requirements

# Report missing values
test_that("missing observations are reported correctly", {
  expect_false(any(grepl("^n/a$", leaders[["HUGGO_ARCHIGOS"]])))
  expect_false(any(grepl("^N/A$", leaders[["HUGGO_ARCHIGOS"]])))
  expect_false(any(grepl("^\\s$", leaders[["HUGGO_ARCHIGOS"]])))
  expect_false(any(grepl("^\\.$", leaders[["HUGGO_ARCHIGOS"]])))
  expect_false(any(grepl("N\\.A\\.$", leaders[["HUGGO_ARCHIGOS"]])))
  expect_false(any(grepl("n\\.a\\.$", leaders[["HUGGO_ARCHIGOS"]])))
})

# Date columns should be in mdate class
test_that("Columns are not in date, POSIXct or POSIXlt class", {
  expect_false(any(lubridate::is.Date(leaders[["HUGGO_ARCHIGOS"]])))
  expect_false(any(lubridate::is.POSIXct(leaders[["HUGGO_ARCHIGOS"]])))
  expect_false(any(lubridate::is.POSIXlt(leaders[["HUGGO_ARCHIGOS"]])))
})
