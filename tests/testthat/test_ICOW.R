# Test if the dataset meets the many packages universe requirements

# Report missing values
test_that("missing observations are reported correctly", {
  expect_false(any(grepl("\\?", states[["ICOW"]])))
  expect_false(any(grepl("^n/a$", states[["ICOW"]])))
  expect_false(any(grepl("^N/A$", states[["ICOW"]])))
  expect_false(any(grepl("^\\s$", states[["ICOW"]])))
  expect_false(any(grepl("^\\.$", states[["ICOW"]])))
  expect_false(any(grepl("N\\.A\\.$", states[["ICOW"]])))
  expect_false(any(grepl("n\\.a\\.$", states[["ICOW"]])))
})

# Date columns should be in messydt class
test_that("Columns are not in date, POSIXct or POSIXlt class", {
  expect_false(any(lubridate::is.Date(states[["ICOW"]])))
  expect_false(any(lubridate::is.POSIXct(states[["ICOW"]])))
  expect_false(any(lubridate::is.POSIXlt(states[["ICOW"]])))
})

# Contains the required variables
test_that("object has the correct variables", {
  pointblank::expect_col_exists(states[["ICOW"]],
                                pointblank::vars(ID))
  pointblank::expect_col_exists(states[["ICOW"]],
                                pointblank::vars(Beg))
  pointblank::expect_col_exists(states[["ICOW"]],
                                pointblank::vars(End))
  pointblank::expect_col_exists(states[["ICOW"]],
                                pointblank::vars(Label))
})

# Variables with dates are standardized
test_that("dates are standardised", {
  expect_s3_class(states[["ICOW"]]$Beg, "mdate")
  expect_s3_class(states[["ICOW"]]$End, "mdate")
  expect_false(any(grepl("/", states[["ICOW"]]$Beg)))
  expect_false(any(grepl("/", states[["ICOW"]]$End)))
})

# Labels are standardized
test_that("labels are standardised", {
  expect_false(any(grepl("U\\.S\\.", states[["ICOW"]])))
  expect_false(any(grepl("U\\.K\\.", states[["ICOW"]])))
  expect_false(any(grepl("!", states[["ICOW"]])))
  expect_false(any(grepl("NANA.", states[["ICOW"]])))
})
