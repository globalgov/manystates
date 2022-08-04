# Test if the dataset meets the many packages universe requirements

# Report missing values
test_that("missing observations are reported correctly", {
  expect_false(any(grepl("^n/a$", economics[["EconomicFreedomHist"]])))
  expect_false(any(grepl("^N/A$", economics[["EconomicFreedomHist"]])))
  expect_false(any(grepl("^\\s$", economics[["EconomicFreedomHist"]])))
  expect_false(any(grepl("^\\.$", economics[["EconomicFreedomHist"]])))
  expect_false(any(grepl("N\\.A\\.$", economics[["EconomicFreedomHist"]])))
  expect_false(any(grepl("n\\.a\\.$", economics[["EconomicFreedomHist"]])))
})

# Date columns should be in mdate class
test_that("Columns are not in date, POSIXct or POSIXlt class", {
  expect_false(any(lubridate::is.Date(economics[["EconomicFreedomHist"]])))
  expect_false(any(lubridate::is.POSIXct(economics[["EconomicFreedomHist"]])))
  expect_false(any(lubridate::is.POSIXlt(economics[["EconomicFreedomHist"]])))
})
