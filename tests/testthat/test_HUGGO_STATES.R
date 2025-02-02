# Test if the dataset meets the many packages universe requirements

# Report missing values
test_that("missing observations are reported correctly", {
  expect_false(any(grepl("\\?", states[["HUGGO_STATES"]][ ,1:11])))
  expect_false(any(grepl("^n/a$", states[["HUGGO_STATES"]])))
  expect_false(any(grepl("^N/A$", states[["HUGGO_STATES"]])))
  expect_false(any(grepl("^\\s$", states[["HUGGO_STATES"]])))
  expect_false(any(grepl("^\\.$", states[["HUGGO_STATES"]])))
  expect_false(any(grepl("N\\.A\\.$", states[["HUGGO_STATES"]])))
  expect_false(any(grepl("n\\.a\\.$", states[["HUGGO_STATES"]])))
})

# Date columns should be in messydt class
test_that("Columns are not in date, POSIXct or POSIXlt class", {
  expect_false(any(lubridate::is.Date(states[["HUGGO_STATES"]])))
  expect_false(any(lubridate::is.POSIXct(states[["HUGGO_STATES"]])))
  expect_false(any(lubridate::is.POSIXlt(states[["HUGGO_STATES"]])))
})

# Contains the required variables
test_that("object has the correct variables", {
  pointblank::expect_col_exists(states[["HUGGO_STATES"]],
                                pointblank::vars(stateID))
  pointblank::expect_col_exists(states[["HUGGO_STATES"]],
                                pointblank::vars(Beg))
  pointblank::expect_col_exists(states[["HUGGO_STATES"]],
                                pointblank::vars(End))
  pointblank::expect_col_exists(states[["HUGGO_STATES"]],
                                pointblank::vars(StateName))
})

# Variables with dates are standardized
test_that("dates are standardised", {
  expect_s3_class(states[["HUGGO_STATES"]]$Beg, "mdate")
  expect_s3_class(states[["HUGGO_STATES"]]$End, "mdate")
  expect_false(any(grepl("/", states[["HUGGO_STATES"]]$Beg)))
  expect_false(any(grepl("/", states[["HUGGO_STATES"]]$End)))
})

# Labels are standardized
test_that("labels are standardised", {
  expect_false(any(grepl("U\\.S\\.", states[["HUGGO_STATES"]])))
  expect_false(any(grepl("U\\.K\\.", states[["HUGGO_STATES"]])))
  expect_false(any(grepl("!", states[["HUGGO_STATES"]])))
  expect_false(any(grepl("NANA.", states[["HUGGO_STATES"]])))
})
