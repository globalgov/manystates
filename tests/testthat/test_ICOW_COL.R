# Test if the dataset meets the many packages universe requirements

# Report missing values
test_that("missing observations are reported correctly", {
  expect_false(any(grepl("\\?", states[["ICOW_COL"]])))
  expect_false(any(grepl("^n/a$", states[["ICOW_COL"]])))
  expect_false(any(grepl("^N/A$", states[["ICOW_COL"]])))
  expect_false(any(grepl("^\\s$", states[["ICOW_COL"]])))
  expect_false(any(grepl("^\\.$", states[["ICOW_COL"]])))
  expect_false(any(grepl("N\\.A\\.$", states[["ICOW_COL"]])))
  expect_false(any(grepl("n\\.a\\.$", states[["ICOW_COL"]])))
})

# Date columns should be in messydt class
test_that("Columns are not in date, POSIXct or POSIXlt class", {
  expect_false(any(lubridate::is.Date(states[["ICOW_COL"]])))
  expect_false(any(lubridate::is.POSIXct(states[["ICOW_COL"]])))
  expect_false(any(lubridate::is.POSIXlt(states[["ICOW_COL"]])))
})

# Contains the required variables
test_that("object has the correct variables", {
  pointblank::expect_col_exists(states[["ICOW_COL"]],
                                pointblank::vars(cowID))
  pointblank::expect_col_exists(states[["ICOW_COL"]],
                                pointblank::vars(Beg))
  pointblank::expect_col_exists(states[["ICOW_COL"]],
                                pointblank::vars(Label))
})

# Variables with dates are standardized
test_that("dates are standardised", {
  expect_s3_class(states[["ICOW_COL"]]$Beg, "mdate")
  expect_false(any(grepl("/", states[["ICOW_COL"]]$Beg)))
})

# Labels are standardized
test_that("labels are standardised", {
  expect_false(any(grepl("U\\.S\\.", states[["ICOW_COL"]])))
  expect_false(any(grepl("U\\.K\\.", states[["ICOW_COL"]])))
  expect_false(any(grepl("!", states[["ICOW_COL"]])))
  expect_false(any(grepl("NANA.", states[["ICOW_COL"]])))
})
