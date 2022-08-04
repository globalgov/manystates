# Test if V-Party meets the many packages universe requirements

# Import v-Party
vdem <- import_vdem()

# Report missing values on a random subset of vdem
test_that("missing observations are reported correctly", {
  expect_false(any(grepl("^n/a$", vdem[sample(nrow(vdem), 1000), ])))
  expect_false(any(grepl("^N/A$", vdem[sample(nrow(vdem), 1000), ])))
  expect_false(any(grepl("^\\s$", vdem[sample(nrow(vdem), 1000), ])))
  expect_false(any(grepl("^\\.$", vdem[sample(nrow(vdem), 1000), ])))
  expect_false(any(grepl("N\\.A\\.$", vdem[sample(nrow(vdem), 1000), ])))
  expect_false(any(grepl("n\\.a\\.$", vdem[sample(nrow(vdem), 1000), ])))
})

# Date columns should be in mdate class
test_that("Columns are not in date, POSIXct or POSIXlt class", {
  expect_false(any(lubridate::is.Date(vdem)))
  expect_false(any(lubridate::is.POSIXct(vdem)))
  expect_false(any(lubridate::is.POSIXlt(vdem)))
})

test_that("Columns with dates are standardized", {
  expect_s3_class(vdem$Beg, "mdate")
  expect_false(any(grepl("/", vdem$Beg)))
  expect_false(any(grepl("^[:alpha:]$",
                         vdem$Beg)))
  expect_false(any(grepl("^[:digit:]{2}$",
                         vdem$Beg)))
  expect_false(any(grepl("^[:digit:]{3}$",
                         vdem$Beg)))
  expect_false(any(grepl("^[:digit:]{1}$",
                         vdem$Beg)))
})

# Contains the required variables
test_that("object has the correct variables", {
  pointblank::expect_col_exists(vdem,
                                pointblank::vars(VDem_ID))
  pointblank::expect_col_exists(vdem,
                                pointblank::vars(Beg))
  pointblank::expect_col_exists(vdem,
                                pointblank::vars(End))
  pointblank::expect_col_exists(vdem,
                                pointblank::vars(Label))
})
