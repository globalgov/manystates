# Test if the dataset meets the many packages universe requirements

# Report missing values
test_that("missing observations are reported correctly", {
  expect_false(any(grepl("^n/a$", regimes[["FHaggregate"]])))
  expect_false(any(grepl("^N/A$", regimes[["FHaggregate"]])))
  expect_false(any(grepl("^\\s$", regimes[["FHaggregate"]])))
  expect_false(any(grepl("^\\.$", regimes[["FHaggregate"]])))
  expect_false(any(grepl("N\\.A\\.$", regimes[["FHaggregate"]])))
  expect_false(any(grepl("n\\.a\\.$", regimes[["FHaggregate"]])))
})

# Date columns should be in mdate class
test_that("Columns are not in date, POSIXct or POSIXlt class", {
  expect_false(any(lubridate::is.Date(regimes[["FHaggregate"]])))
  expect_false(any(lubridate::is.POSIXct(regimes[["FHaggregate"]])))
  expect_false(any(lubridate::is.POSIXlt(regimes[["FHaggregate"]])))
})
