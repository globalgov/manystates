# Test if V-Party meets the manyverse requirements

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

# Date columns should be in messydt class
test_that("Columns are not in date, POSIXct or POSIXlt class", {
  expect_false(any(lubridate::is.Date(vparty)))
  expect_false(any(lubridate::is.POSIXct(vparty)))
  expect_false(any(lubridate::is.POSIXlt(vparty)))
})

test_that("Columns with dates are standardized", {
  expect_equal(class(vparty$Beg), "messydt")
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
  expect_col_exists(vparty, vars(ID))
  expect_col_exists(vparty, vars(Beg))
  expect_col_exists(vparty, vars(End))
  expect_col_exists(vparty, vars(Label))
})
