# Test if the dataset meets the many packages universe requirements

# Report missing values
test_that("missing observations are reported correctly", {
  expect_false(any(grepl("^n/a$", colrels[["ICOW_COL"]])))
  expect_false(any(grepl("^N/A$", colrels[["ICOW_COL"]])))
  expect_false(any(grepl("^\\s$", colrels[["ICOW_COL"]])))
  expect_false(any(grepl("^\\.$", colrels[["ICOW_COL"]])))
  expect_false(any(grepl("N\\.A\\.$", colrels[["ICOW_COL"]])))
  expect_false(any(grepl("n\\.a\\.$", colrels[["ICOW_COL"]])))
})

# Date columns should be in mdate class
test_that("Columns are not in date, POSIXct or POSIXlt class", {
  expect_false(any(lubridate::is.Date(colrels[["ICOW_COL"]])))
  expect_false(any(lubridate::is.POSIXct(colrels[["ICOW_COL"]])))
  expect_false(any(lubridate::is.POSIXlt(colrels[["ICOW_COL"]])))
})
