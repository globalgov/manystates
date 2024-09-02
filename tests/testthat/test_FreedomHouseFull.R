# Test if the dataset meets the many packages universe requirements

# Report missing values
test_that("missing observations are reported correctly", {
  expect_false(any(grepl("^n/a$", regimes[["FreedomHouseFull"]])))
  expect_false(any(grepl("^N/A$", regimes[["FreedomHouseFull"]])))
  expect_false(any(grepl("^\\s$", regimes[["FreedomHouseFull"]])))
  expect_false(any(grepl("^\\.$", regimes[["FreedomHouseFull"]])))
  expect_false(any(grepl("N\\.A\\.$", regimes[["FreedomHouseFull"]])))
  expect_false(any(grepl("n\\.a\\.$", regimes[["FreedomHouseFull"]])))
})

# Date columns should be in mdate class
test_that("Columns are not in date, POSIXct or POSIXlt class", {
  expect_false(any(lubridate::is.Date(regimes[["FreedomHouseFull"]])))
  expect_false(any(lubridate::is.POSIXct(regimes[["FreedomHouseFull"]])))
  expect_false(any(lubridate::is.POSIXlt(regimes[["FreedomHouseFull"]])))
})

# Contains the required variables
test_that("object has the correct variables", {
  pointblank::expect_col_exists(states[["FreedomHouseFull"]],
                                pointblank::vars(stateID))
  pointblank::expect_col_exists(states[["FreedomHouseFull"]],
                                pointblank::vars(StateName))
})
