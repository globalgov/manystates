# Test if the dataset meets the many packages universe requirements

# Report missing values
test_that("missing observations are reported correctly", {
  expect_false(any(grepl("^n/a$", regimes[["Polity5"]])))
  expect_false(any(grepl("^N/A$", regimes[["Polity5"]])))
  expect_false(any(grepl("^\\s$", regimes[["Polity5"]])))
  expect_false(any(grepl("^\\.$", regimes[["Polity5"]])))
  expect_false(any(grepl("N\\.A\\.$", regimes[["Polity5"]])))
  expect_false(any(grepl("n\\.a\\.$", regimes[["Polity5"]])))
})

# Date columns should be in mdate class
test_that("Columns are not in date, POSIXct or POSIXlt class", {
  expect_false(any(lubridate::is.Date(regimes[["Polity5"]])))
  expect_false(any(lubridate::is.POSIXct(regimes[["Polity5"]])))
  expect_false(any(lubridate::is.POSIXlt(regimes[["Polity5"]])))
})

# Contains the required variables
test_that("object has the correct variables", {
  pointblank::expect_col_exists(states[["Polity5"]],
                                pointblank::vars(stateID))
  pointblank::expect_col_exists(states[["Polity5"]],
                                pointblank::vars(StateName))
})
