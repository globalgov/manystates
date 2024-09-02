# Test if the dataset meets the many packages universe requirements

# Report missing values
test_that("missing observations are reported correctly", {
  expect_false(any(grepl("^\\?$", states[["ICOW"]])))
  expect_false(any(grepl("^n/a$", states[["ICOW"]])))
  expect_false(any(grepl("^N/A$", states[["ICOW"]])))
  expect_false(any(grepl("^\\s$", states[["ICOW"]])))
  expect_false(any(grepl("^\\.$", states[["ICOW"]])))
  expect_false(any(grepl("N\\.A\\.$", states[["ICOW"]])))
  expect_false(any(grepl("n\\.a\\.$", states[["ICOW"]])))
})

# Date columns should be in mdate class
test_that("Columns are not in date, POSIXct or POSIXlt class", {
  expect_false(any(lubridate::is.Date(states[["ICOW"]])))
  expect_false(any(lubridate::is.POSIXct(states[["ICOW"]])))
  expect_false(any(lubridate::is.POSIXlt(states[["ICOW"]])))
})

# Contains the required variables
test_that("object has the correct variables", {
  pointblank::expect_col_exists(states[["ICOW"]],
                                pointblank::vars(StateName))
  pointblank::expect_col_exists(states[["ICOW"]],
                                pointblank::vars(stateID))
  pointblank::expect_col_exists(states[["ICOW"]],
                                pointblank::vars(Begin))
  pointblank::expect_col_exists(states[["ICOW"]],
                                pointblank::vars(SecDate))
  pointblank::expect_col_exists(states[["ICOW"]],
                                pointblank::vars(IntoDate))
})

# Variables with dates are standardized
test_that("dates are standardised", {
  expect_s3_class(states[["ICOW"]]$Begin, "mdate")
  expect_s3_class(states[["ICOW"]]$SecDate, "mdate")
  expect_s3_class(states[["ICOW"]]$IntoDate, "mdate")
  expect_false(any(grepl("/", states[["ICOW"]]$Begin)))
  expect_false(any(grepl("/", states[["ICOW"]]$SecDate)))
  expect_false(any(grepl("/", states[["ICOW"]]$IntoDate)))
})

# Labels are standardized
test_that("labels are standardised", {
  expect_false(any(grepl("U\\.S\\.", states[["ICOW"]])))
  expect_false(any(grepl("U\\.K\\.", states[["ICOW"]])))
  expect_false(any(grepl("!", states[["ICOW"]])))
  expect_false(any(grepl("NANA.", states[["ICOW"]])))
})
