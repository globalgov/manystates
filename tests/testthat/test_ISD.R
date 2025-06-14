# Test if the dataset meets the many packages universe requirements

# Report missing values
test_that("missing observations are reported correctly", {
  expect_false(any(grepl("^n/a$", states[["ISD"]])))
  expect_false(any(grepl("^N/A$", states[["ISD"]])))
  expect_false(any(grepl("^\\s$", states[["ISD"]])))
  expect_false(any(grepl("^\\.$", states[["ISD"]])))
  expect_false(any(grepl("N\\.A\\.$", states[["ISD"]])))
  expect_false(any(grepl("n\\.a\\.$", states[["ISD"]])))
})

# Date columns should be in mdate class
test_that("Columns are not in date, POSIXct or POSIXlt class", {
  expect_false(any(lubridate::is.Date(states[["ISD"]])))
  expect_false(any(lubridate::is.POSIXct(states[["ISD"]])))
  expect_false(any(lubridate::is.POSIXlt(states[["ISD"]])))
})

# Contains the required variables
test_that("object has the correct variables", {
  pointblank::expect_col_exists(states[["ISD"]],
                                pointblank::vars(stateID))
  pointblank::expect_col_exists(states[["ISD"]],
                                pointblank::vars(Begin))
  pointblank::expect_col_exists(states[["ISD"]],
                                pointblank::vars(End))
  pointblank::expect_col_exists(states[["ISD"]],
                                pointblank::vars(StateName))
})

# Variables with dates are standardized
test_that("dates are standardised", {
  expect_s3_class(states[["ISD"]]$Begin, "mdate")
  expect_s3_class(states[["ISD"]]$End, "mdate")
  expect_false(any(grepl("/", states[["ISD"]]$Begin)))
  expect_false(any(grepl("/", states[["ISD"]]$End)))
})

# State names are standardized
test_that("labels are standardised", {
  expect_false(any(grepl("U\\.S\\.", states[["ISD"]])))
  expect_false(any(grepl("U\\.K\\.", states[["ISD"]])))
  expect_false(any(grepl("!", states[["ISD"]])))
  expect_false(any(grepl("NANA.", states[["ISD"]])))
})
