# Test if V-Party meets the manyverse requirements

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

# Date columns should be in messydt class
test_that("Columns are not in date, POSIXct or POSIXlt class", {
  expect_false(any(lubridate::is.Date(vdem)))
  expect_false(any(lubridate::is.POSIXct(vdem)))
  expect_false(any(lubridate::is.POSIXlt(vdem)))
})

test_that("Columns with dates are standardized", {
  expect_equal(class(vdem$Beg), "messydt")
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
  expect_col_exists(vdem, vars(ID))
  expect_col_exists(vdem, vars(Beg))
  expect_col_exists(vdem, vars(End))
  expect_col_exists(vdem, vars(Label))
})
