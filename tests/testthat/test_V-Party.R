# Test if V-Party meets the many packages universe requirements

# Import v-Party
vparty <- import_vparty()

# Report missing values on a random subset of vparty
test_that("missing observations are reported correctly", {
  expect_false(any(grepl("^n/a$", vparty[sample(nrow(vparty), 1000), ])))
  expect_false(any(grepl("^N/A$", vparty[sample(nrow(vparty), 1000), ])))
  expect_false(any(grepl("^\\s$", vparty[sample(nrow(vparty), 1000), ])))
  expect_false(any(grepl("^\\.$", vparty[sample(nrow(vparty), 1000), ])))
  expect_false(any(grepl("N\\.A\\.$", vparty[sample(nrow(vparty), 1000), ])))
  expect_false(any(grepl("n\\.a\\.$", vparty[sample(nrow(vparty), 1000), ])))
})

# Date columns should be in mdate class
test_that("Columns are not in date, POSIXct or POSIXlt class", {
  expect_false(any(lubridate::is.Date(vparty)))
  expect_false(any(lubridate::is.POSIXct(vparty)))
  expect_false(any(lubridate::is.POSIXlt(vparty)))
})

test_that("Columns with dates are standardized", {
  expect_s3_class(vparty$Beg, "mdate")
  expect_false(any(grepl("/", vparty$Beg)))
  expect_false(any(grepl("^[:alpha:]$",
                         vparty$Beg)))
  expect_false(any(grepl("^[:digit:]{2}$",
                         vparty$Beg)))
  expect_false(any(grepl("^[:digit:]{3}$",
                         vparty$Beg)))
  expect_false(any(grepl("^[:digit:]{1}$",
                         vparty$Beg)))
})

# Contains the required variables
test_that("object has the correct variables", {
  pointblank::expect_col_exists(vparty,
                                pointblank::vars(vpartyID))
  pointblank::expect_col_exists(vparty,
                                pointblank::vars(Beg))
  pointblank::expect_col_exists(vparty,
                                pointblank::vars(End))
  pointblank::expect_col_exists(vparty,
                                pointblank::vars(Party))
})
