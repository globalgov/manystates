# Test if the dataset meets the many packages universe requirements

# Report missing values
test_that("missing observations are reported correctly", {
  expect_false(any(grepl("^n/a$", contiguity[["COW"]])))
  expect_false(any(grepl("^N/A$", contiguity[["COW"]])))
  expect_false(any(grepl("^\\s$", contiguity[["COW"]])))
  expect_false(any(grepl("^\\.$", contiguity[["COW"]])))
  expect_false(any(grepl("N\\.A\\.$", contiguity[["COW"]])))
  expect_false(any(grepl("n\\.a\\.$", contiguity[["COW"]])))
})

# Date columns should be in mdate class
# test_that("Columns are not in date, POSIXct or POSIXlt class", {
#   expect_false(any(lubridate::is.Date(contiguity[["COW"]])))
#   expect_false(any(lubridate::is.POSIXct(contiguity[["COW"]])))
#   expect_false(any(lubridate::is.POSIXlt(contiguity[["COW"]])))
# })
