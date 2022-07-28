# Test if the dataset meets the many packages universe requirements

# Report missing values
test_that("missing observations are reported correctly", {
  expect_false(any(grepl("\\?", states[["COW"]])))
  expect_false(any(grepl("^n/a$", states[["COW"]])))
  expect_false(any(grepl("^N/A$", states[["COW"]])))
  expect_false(any(grepl("^\\s$", states[["COW"]])))
  expect_false(any(grepl("^\\.$", states[["COW"]])))
  expect_false(any(grepl("N\\.A\\.$", states[["COW"]])))
  expect_false(any(grepl("n\\.a\\.$", states[["COW"]])))
})

# Date columns should be in messydt class
test_that("Columns are not in date, POSIXct or POSIXlt class", {
  expect_false(any(lubridate::is.Date(states[["COW"]])))
  expect_false(any(lubridate::is.POSIXct(states[["COW"]])))
  expect_false(any(lubridate::is.POSIXlt(states[["COW"]])))
})

# Contains the required variables
test_that("object has the correct variables", {
  pointblank::expect_col_exists(states[["COW"]],
                                pointblank::vars(ID))
  pointblank::expect_col_exists(states[["COW"]],
                                pointblank::vars(Beg))
  pointblank::expect_col_exists(states[["COW"]],
                                pointblank::vars(End))
  pointblank::expect_col_exists(states[["COW"]],
                                pointblank::vars(Label))
})

# Variables with dates are standardized
test_that("dates are standardised", {
  expect_s3_class(states[["COW"]]$Beg, "mdate")
  expect_s3_class(states[["COW"]]$End, "mdate")
  expect_false(any(grepl("/", states[["COW"]]$Beg)))
  expect_false(any(grepl("/", states[["COW"]]$End)))
})

# Labels are standardized
test_that("labels are standardised", {
  expect_false(any(grepl("U\\.S\\.", states[["COW"]])))
  expect_false(any(grepl("U\\.K\\.", states[["COW"]])))
  expect_false(any(grepl("!", states[["COW"]])))
  expect_false(any(grepl("NANA.", states[["COW"]])))
})
