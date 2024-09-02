# Test if the dataset meets the many packages universe requirements

# Report missing values
test_that("missing observations are reported correctly", {
  expect_false(any(grepl("\\?", states[["GW"]])))
  expect_false(any(grepl("^n/a$", states[["GW"]])))
  expect_false(any(grepl("^N/A$", states[["GW"]])))
  expect_false(any(grepl("^\\s$", states[["GW"]])))
  expect_false(any(grepl("^\\.$", states[["GW"]])))
  expect_false(any(grepl("N\\.A\\.$", states[["GW"]])))
  expect_false(any(grepl("n\\.a\\.$", states[["GW"]])))
})

# Date columns should be in mdate class
test_that("Columns are not in date, POSIXct or POSIXlt class", {
  expect_false(any(lubridate::is.Date(states[["GW"]])))
  expect_false(any(lubridate::is.POSIXct(states[["GW"]])))
  expect_false(any(lubridate::is.POSIXlt(states[["GW"]])))
})

# Contains the required variables
test_that("object has the correct variables", {
  pointblank::expect_col_exists(states[["GW"]],
                                pointblank::vars(stateID))
  pointblank::expect_col_exists(states[["GW"]],
                                pointblank::vars(Begin))
  pointblank::expect_col_exists(states[["GW"]],
                                pointblank::vars(End))
  pointblank::expect_col_exists(states[["GW"]],
                                pointblank::vars(StateName))
})

# Variables with dates are standardized
test_that("dates are standardised", {
  expect_s3_class(states[["GW"]]$Begin, "mdate")
  expect_s3_class(states[["GW"]]$End, "mdate")
  expect_false(any(grepl("/", states[["GW"]]$Begin)))
  expect_false(any(grepl("/", states[["GW"]]$End)))
})

# Labels are standardized
test_that("labels are standardised", {
  expect_false(any(grepl("U\\.S\\.", states[["GW"]])))
  expect_false(any(grepl("U\\.K\\.", states[["GW"]])))
  expect_false(any(grepl("!", states[["GW"]])))
  expect_false(any(grepl("NANA.", states[["GW"]])))
})
