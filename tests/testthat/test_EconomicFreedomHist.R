# Test if the dataset meets the many packages universe requirements

# Report missing values
test_that("missing observations are reported correctly", {
  expect_false(any(grepl("\\?", economics[["EconomicFreedomHist"]])))
  expect_false(any(grepl("^n/a$", economics[["EconomicFreedomHist"]])))
  expect_false(any(grepl("^N/A$", economics[["EconomicFreedomHist"]])))
  expect_false(any(grepl("^\\s$", economics[["EconomicFreedomHist"]])))
  expect_false(any(grepl("^\\.$", economics[["EconomicFreedomHist"]])))
  expect_false(any(grepl("N\\.A\\.$", economics[["EconomicFreedomHist"]])))
  expect_false(any(grepl("n\\.a\\.$", economics[["EconomicFreedomHist"]])))
})

# Contains the main variables
test_that("object has the correct variables", {
  expect_col_exists(economics[["EconomicFreedomHist"]], vars(COW_ID))
  expect_col_exists(economics[["EconomicFreedomHist"]], vars(Year))
  expect_col_exists(economics[["EconomicFreedomHist"]], vars(Country))
})

# Variables with dates are standardized
test_that("Columns with dates are standardized", {
  expect_equal(class(economics[["EconomicFreedomHist"]]$Year), "messydt")
  expect_false(any(grepl("/", economics[["EconomicFreedomHist"]]$Year)))
  expect_false(any(grepl("^[:alpha:]$",
                         economics[["EconomicFreedomHist"]]$Year)))
  expect_false(any(grepl("^[:digit:]{2}$",
                         economics[["EconomicFreedomHist"]]$Year)))
  expect_false(any(grepl("^[:digit:]{3}$",
                         economics[["EconomicFreedomHist"]]$Year)))
  expect_false(any(grepl("^[:digit:]{1}$",
                         economics[["EconomicFreedomHist"]]$Year)))
})

# Labels are standardized
test_that("labels are standardised", {
  expect_false(any(grepl("U\\.S\\.", economics[["EconomicFreedomHist"]])))
  expect_false(any(grepl("U.K.", economics[["EconomicFreedomHist"]])))
  expect_false(any(grepl("!", economics[["EconomicFreedomHist"]])))
  expect_false(any(grepl("NANA.", economics[["EconomicFreedomHist"]])))
})
