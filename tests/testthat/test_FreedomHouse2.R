# Test if  meets the many packages universe requirements
# 
# Report missing values
test_that("missing observations are reported correctly", {
  expect_false(any(grepl("^n/a$", regimes[["FreedomHouse2"]])))
  expect_false(any(grepl("^N/A$", regimes[["FreedomHouse2"]])))
  expect_false(any(grepl("^\\s$", regimes[["FreedomHouse2"]])))
  expect_false(any(grepl("^\\.$", regimes[["FreedomHouse2"]])))
  expect_false(any(grepl("N\\.A\\.$", regimes[["FreedomHouse2"]])))
  expect_false(any(grepl("n\\.a\\.$", regimes[["FreedomHouse2"]])))
})

# Date columns should be in messydt class
test_that("Columns are not in date, POSIXct or POSIXlt class", {
  expect_false(any(lubridate::is.Date(regimes[["FreedomHouse2"]])))
  expect_false(any(lubridate::is.POSIXct(regimes[["FreedomHouse2"]])))
  expect_false(any(lubridate::is.POSIXlt(regimes[["FreedomHouse2"]])))
})

test_that("Columns with dates are standardized", {
  expect_equal(class(regimes[["FreedomHouse2"]]$Year), "messydt")
  expect_false(any(grepl("/", regimes[["FreedomHouse2"]]$Year)))
  expect_false(any(grepl("^[:alpha:]$",
                         regimes[["FreedomHouse2"]]$Year)))
  expect_false(any(grepl("^[:digit:]{2}$",
                         regimes[["FreedomHouse2"]]$Year)))
  expect_false(any(grepl("^[:digit:]{3}$",
                         regimes[["FreedomHouse2"]]$Year)))
  expect_false(any(grepl("^[:digit:]{1}$",
                         regimes[["FreedomHouse2"]]$Year)))
})

# Contains the required variables
test_that("object has the correct variables", {
  expect_col_exists(regimes[["FreedomHouse2"]], vars(ID))
  expect_col_exists(regimes[["FreedomHouse2"]], vars(Year))
  expect_col_exists(regimes[["FreedomHouse2"]], vars(Label))
})

# Labels are standardized
test_that("labels are standardised", {
  expect_false(any(grepl("U\\.S\\.", regimes[["FreedomHouse2"]])))
  expect_false(any(grepl("U.K.", regimes[["FreedomHouse2"]])))
  expect_false(any(grepl("!", regimes[["FreedomHouse2"]])))
  expect_false(any(grepl("NANA.", regimes[["FreedomHouse2"]])))
})
