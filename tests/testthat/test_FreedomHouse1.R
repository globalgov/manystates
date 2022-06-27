# Test if the dataset meets the many packages universe requirements

# Report missing values
test_that("missing observations are reported correctly", {
  expect_false(any(grepl("^n/a$", regimes[["FreedomHouse1"]])))
  expect_false(any(grepl("^N/A$", regimes[["FreedomHouse1"]])))
  expect_false(any(grepl("^\\s$", regimes[["FreedomHouse1"]])))
  expect_false(any(grepl("^\\.$", regimes[["FreedomHouse1"]])))
  expect_false(any(grepl("N\\.A\\.$", regimes[["FreedomHouse1"]])))
  expect_false(any(grepl("n\\.a\\.$", regimes[["FreedomHouse1"]])))
})

# Date columns should be in mdate class
test_that("Columns are not in date, POSIXct or POSIXlt class", {
  expect_false(any(lubridate::is.Date(regimes[["FreedomHouse1"]])))
  expect_false(any(lubridate::is.POSIXct(regimes[["FreedomHouse1"]])))
  expect_false(any(lubridate::is.POSIXlt(regimes[["FreedomHouse1"]])))
})

test_that("Columns with dates are standardized", {
  expect_equal(class(regimes[["FreedomHouse1"]]$Year), "mdate")
  expect_false(any(grepl("/", regimes[["FreedomHouse1"]]$Year)))
  expect_false(any(grepl("^[:alpha:]$",
                         regimes[["FreedomHouse1"]]$Year)))
  expect_false(any(grepl("^[:digit:]{2}$",
                         regimes[["FreedomHouse1"]]$Year)))
  expect_false(any(grepl("^[:digit:]{3}$",
                         regimes[["FreedomHouse1"]]$Year)))
  expect_false(any(grepl("^[:digit:]{1}$",
                         regimes[["FreedomHouse1"]]$Year)))
})

# Contains the required variables
test_that("object has the correct variables", {
  pointblank::expect_col_exists(regimes[["FreedomHouse1"]],
                                pointblank::vars(COW_ID))
  pointblank::expect_col_exists(regimes[["FreedomHouse1"]],
                                pointblank::vars(ID))
  expect_true(is.character(regimes[["FreedomHouse1"]][["ID"]]))
  pointblank::expect_col_exists(regimes[["FreedomHouse1"]],
                                pointblank::vars(Year))
  pointblank::expect_col_exists(regimes[["FreedomHouse1"]],
                                pointblank::vars(Label))
})

# Labels are standardized
test_that("labels are standardised", {
  expect_false(any(grepl("U\\.S\\.", regimes[["FreedomHouse1"]])))
  expect_false(any(grepl("U.K.", regimes[["FreedomHouse1"]])))
  expect_false(any(grepl("!", regimes[["FreedomHouse1"]])))
  expect_false(any(grepl("NANA.", regimes[["FreedomHouse1"]])))
})
