# Test if  meets the q ecosystem requirements

# Report missing values
test_that("missing observations are reported correctly", {
  expect_false(any(grepl("^n/a$", regimes[["V-Party"]])))
  expect_false(any(grepl("^N/A$", regimes[["V-Party"]])))
  expect_false(any(grepl("^\\s$", regimes[["V-Party"]])))
  expect_false(any(grepl("^\\.$", regimes[["V-Party"]])))
  expect_false(any(grepl("N\\.A\\.$", regimes[["V-Party"]])))
  expect_false(any(grepl("n\\.a\\.$", regimes[["V-Party"]])))
})

# Date columns should be in messydt class
test_that("Columns are not in date, POSIXct or POSIXlt class", {
  expect_false(any(lubridate::is.Date(regimes[["V-Party"]])))
  expect_false(any(lubridate::is.POSIXct(regimes[["V-Party"]])))
  expect_false(any(lubridate::is.POSIXlt(regimes[["V-Party"]])))
})
