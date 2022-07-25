# Test if the dataset meets the many packages universe requirements

# Report missing values
test_that("missing observations are reported correctly", {
  expect_false(any(grepl("\\?", economics[["EconomicFreedom"]])))
  expect_false(any(grepl("^n/a$", economics[["EconomicFreedom"]])))
  expect_false(any(grepl("^N/A$", economics[["EconomicFreedom"]])))
  expect_false(any(grepl("^\\s$", economics[["EconomicFreedom"]])))
  expect_false(any(grepl("^\\.$", economics[["EconomicFreedom"]])))
  expect_false(any(grepl("N\\.A\\.$", economics[["EconomicFreedom"]])))
  expect_false(any(grepl("n\\.a\\.$", economics[["EconomicFreedom"]])))
})

# Contains the main variables
test_that("object has the correct variables", {
  pointblank::expect_col_exists(economics[["EconomicFreedom"]],
                                pointblank::vars(COW_ID))
  pointblank::expect_col_exists(economics[["EconomicFreedom"]],
                                pointblank::vars(Year))
  pointblank::expect_col_exists(economics[["EconomicFreedom"]],
                                pointblank::vars(Countries))
})

# Variables with dates are standardized
test_that("Columns with dates are standardized", {
  expect_equal(class(economics[["EconomicFreedom"]]$Year), "mdate")
  expect_false(any(grepl("/", economics[["EconomicFreedom"]]$Year)))
  expect_false(any(grepl("^[:alpha:]$",
                         economics[["EconomicFreedom"]]$Year)))
  expect_false(any(grepl("^[:digit:]{2}$",
                         economics[["EconomicFreedom"]]$Year)))
  expect_false(any(grepl("^[:digit:]{3}$",
                         economics[["EconomicFreedom"]]$Year)))
  expect_false(any(grepl("^[:digit:]{1}$",
                         economics[["EconomicFreedom"]]$Year)))
})

# Labels are standardized
test_that("labels are standardised", {
  expect_false(any(grepl("U\\.S\\.", economics[["EconomicFreedom"]])))
  expect_false(any(grepl("U.K.", economics[["EconomicFreedom"]])))
  expect_false(any(grepl("!", economics[["EconomicFreedom"]])))
  expect_false(any(grepl("NANA.", economics[["EconomicFreedom"]])))
})
