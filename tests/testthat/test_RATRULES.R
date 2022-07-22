# Test if the dataset meets the many packages universe requirements

# Report missing values
test_that("missing observations are reported correctly", {
  expect_false(any(grepl("^n/a$", ratrules[["RATRULES"]])))
  expect_false(any(grepl("^N/A$", ratrules[["RATRULES"]])))
  expect_false(any(grepl("^\\s$", ratrules[["RATRULES"]])))
  expect_false(any(grepl("^\\.$", ratrules[["RATRULES"]])))
  expect_false(any(grepl("N\\.A\\.$", ratrules[["RATRULES"]])))
  expect_false(any(grepl("n\\.a\\.$", ratrules[["RATRULES"]])))
})

# Date columns should be in mdate class
test_that("Columns are not in date, POSIXct or POSIXlt class", {
  expect_false(any(lubridate::is.Date(ratrules[["RATRULES"]])))
  expect_false(any(lubridate::is.POSIXct(ratrules[["RATRULES"]])))
  expect_false(any(lubridate::is.POSIXlt(ratrules[["RATRULES"]])))
})
