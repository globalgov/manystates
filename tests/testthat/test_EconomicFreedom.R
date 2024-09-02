# Test if the dataset meets the many packages universe requirements

# Report missing values
test_that("missing observations are reported correctly", {
  expect_false(any(grepl("\\?", states[["EconomicFreedom"]])))
  expect_false(any(grepl("^n/a$", states[["EconomicFreedom"]])))
  expect_false(any(grepl("^N/A$", states[["EconomicFreedom"]])))
  expect_false(any(grepl("^\\s$", states[["EconomicFreedom"]])))
  expect_false(any(grepl("^\\.$", states[["EconomicFreedom"]])))
  expect_false(any(grepl("N\\.A\\.$", states[["EconomicFreedom"]])))
  expect_false(any(grepl("n\\.a\\.$", states[["EconomicFreedom"]])))
})

# Date columns should be in mdate class
test_that("Columns are not in date, POSIXct or POSIXlt class", {
  expect_false(any(lubridate::is.Date(states[["EconomicFreedom"]])))
  expect_false(any(lubridate::is.POSIXct(states[["EconomicFreedom"]])))
  expect_false(any(lubridate::is.POSIXlt(states[["EconomicFreedom"]])))
})

# Contains the required variables
test_that("object has the correct variables", {
  pointblank::expect_col_exists(states[["EconomicFreedom"]],
                                pointblank::vars(stateID))
  pointblank::expect_col_exists(states[["EconomicFreedom"]],
                                pointblank::vars(StateName))
})

# Variables with dates are standardized
test_that("dates are standardised", {
  expect_s3_class(states[["EconomicFreedom"]]$Year, "mdate")
  expect_false(any(grepl("/", states[["EconomicFreedom"]]$Year)))
})

# Labels are standardized
test_that("labels are standardised", {
  expect_false(any(grepl("U\\.S\\.", states[["EconomicFreedom"]])))
  expect_false(any(grepl("U\\.K\\.", states[["EconomicFreedom"]])))
  expect_false(any(grepl("!", states[["EconomicFreedom"]])))
  expect_false(any(grepl("NANA.", states[["EconomicFreedom"]])))
})
