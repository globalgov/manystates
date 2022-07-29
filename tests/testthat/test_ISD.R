# Test if the dataset meets the many packages universe requirements

# Report missing values
test_that("missing observations are reported correctly", {
  expect_false(any(grepl("\\?", states[["ISD"]])))
  expect_false(any(grepl("^n/a$", states[["ISD"]])))
  expect_false(any(grepl("^N/A$", states[["ISD"]])))
  expect_false(any(grepl("^\\s$", states[["ISD"]])))
  expect_false(any(grepl("^\\.$", states[["ISD"]])))
  expect_false(any(grepl("N\\.A\\.$", states[["ISD"]])))
  expect_false(any(grepl("n\\.a\\.$", states[["ISD"]])))
})

# Date columns should be in messydt class
test_that("Columns are not in date, POSIXct or POSIXlt class", {
  expect_false(any(lubridate::is.Date(states[["ISD"]])))
  expect_false(any(lubridate::is.POSIXct(states[["ISD"]])))
  expect_false(any(lubridate::is.POSIXlt(states[["ISD"]])))
})

# Contains the required variables
test_that("object has the correct variables", {
  pointblank::expect_col_exists(states[["ISD"]],
                                pointblank::vars(cowID))
  pointblank::expect_col_exists(states[["ISD"]],
                                pointblank::vars(Beg))
  pointblank::expect_col_exists(states[["ISD"]],
                                pointblank::vars(End))
  pointblank::expect_col_exists(states[["ISD"]],
                                pointblank::vars(Label))
})

# Variables with dates are standardized
test_that("dates are standardised", {
  expect_s3_class(states[["ISD"]]$Beg, "mdate")
  expect_s3_class(states[["ISD"]]$End, "mdate")
  expect_false(any(grepl("/", states[["ISD"]]$Beg)))
  expect_false(any(grepl("/", states[["ISD"]]$End)))
})

# Labels are standardized
test_that("labels are standardised", {
  expect_false(any(grepl("U\\.S\\.", states[["ISD"]])))
  expect_false(any(grepl("U\\.K\\.", states[["ISD"]])))
  expect_false(any(grepl("!", states[["ISD"]])))
  expect_false(any(grepl("NANA.", states[["ISD"]])))
})
