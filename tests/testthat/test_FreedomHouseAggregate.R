# Test if the dataset meets the many packages universe requirements

# Report missing values
test_that("missing observations are reported correctly", {
  expect_false(any(grepl("^n/a$", regimes[["FreedomHouseAggregate"]])))
  expect_false(any(grepl("^N/A$", regimes[["FreedomHouseAggregate"]])))
  expect_false(any(grepl("^\\s$", regimes[["FreedomHouseAggregate"]])))
  expect_false(any(grepl("^\\.$", regimes[["FreedomHouseAggregate"]])))
  expect_false(any(grepl("N\\.A\\.$", regimes[["FreedomHouseAggregate"]])))
  expect_false(any(grepl("n\\.a\\.$", regimes[["FreedomHouseAggregate"]])))
})

# Date columns should be in mdate class
test_that("Columns are not in date, POSIXct or POSIXlt class", {
  expect_false(any(lubridate::is.Date(regimes[["FreedomHouseAggregate"]])))
  expect_false(any(lubridate::is.POSIXct(regimes[["FreedomHouseAggregate"]])))
  expect_false(any(lubridate::is.POSIXlt(regimes[["FreedomHouseAggregate"]])))
})
