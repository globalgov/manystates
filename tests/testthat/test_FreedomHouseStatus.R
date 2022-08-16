# Test if the dataset meets the many packages universe requirements

# Report missing values
test_that("missing observations are reported correctly", {
  expect_false(any(grepl("^n/a$", regimes[["FreedomHouseStatus"]])))
  expect_false(any(grepl("^N/A$", regimes[["FreedomHouseStatus"]])))
  expect_false(any(grepl("^\\s$", regimes[["FreedomHouseStatus"]])))
  expect_false(any(grepl("^\\.$", regimes[["FreedomHouseStatus"]])))
  expect_false(any(grepl("N\\.A\\.$", regimes[["FreedomHouseStatus"]])))
  expect_false(any(grepl("n\\.a\\.$", regimes[["FreedomHouseStatus"]])))
})

# Date columns should be in mdate class
test_that("Columns are not in date, POSIXct or POSIXlt class", {
  expect_false(any(lubridate::is.Date(regimes[["FreedomHouseStatus"]])))
  expect_false(any(lubridate::is.POSIXct(regimes[["FreedomHouseStatus"]])))
  expect_false(any(lubridate::is.POSIXlt(regimes[["FreedomHouseStatus"]])))
})
