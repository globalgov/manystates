# Test if the dataset meets the many packages universe requirements

# Report missing values
test_that("missing observations are reported correctly", {
  expect_false(any(grepl("^n/a$", leaders[["ARCHIGOS"]])))
  expect_false(any(grepl("^N/A$", leaders[["ARCHIGOS"]])))
  expect_false(any(grepl("^\\s$", leaders[["ARCHIGOS"]])))
  expect_false(any(grepl("^\\.$", leaders[["ARCHIGOS"]])))
  expect_false(any(grepl("N\\.A\\.$", leaders[["ARCHIGOS"]])))
  expect_false(any(grepl("n\\.a\\.$", leaders[["ARCHIGOS"]])))
})

# Date columns should be in messydt class
test_that("Columns are not in date, POSIXct or POSIXlt class", {
  expect_false(any(lubridate::is.Date(leaders[["ARCHIGOS"]])))
  expect_false(any(lubridate::is.POSIXct(leaders[["ARCHIGOS"]])))
  expect_false(any(lubridate::is.POSIXlt(leaders[["ARCHIGOS"]])))
})

test_that("Columns with dates are standardized", {
  expect_equal(class(leaders[["ARCHIGOS"]]$Beg), "messydt")
  expect_false(any(grepl("/", leaders[["ARCHIGOS"]]$Beg)))
  expect_false(any(grepl("^[:alpha:]$",
                         leaders[["ARCHIGOS"]]$Beg)))
  expect_false(any(grepl("^[:digit:]{2}$",
                         leaders[["ARCHIGOS"]]$Beg)))
  expect_false(any(grepl("^[:digit:]{3}$",
                         leaders[["ARCHIGOS"]]$Beg)))
  expect_false(any(grepl("^[:digit:]{1}$",
                         leaders[["ARCHIGOS"]]$Beg)))
})

# Contains the required variables
test_that("object has the correct variables", {
  expect_col_exists(leaders[["ARCHIGOS"]], vars(ARCHIGOS_ID))
  expect_col_exists(leaders[["ARCHIGOS"]], vars(Beg))
  expect_col_exists(leaders[["ARCHIGOS"]], vars(End))
  expect_col_exists(leaders[["ARCHIGOS"]], vars(Label))
})

# Labels are standardized
test_that("labels are standardised", {
  expect_false(any(grepl("U\\.S\\.", leaders[["ARCHIGOS"]])))
  expect_false(any(grepl("U.K.", leaders[["ARCHIGOS"]])))
  expect_false(any(grepl("!", leaders[["ARCHIGOS"]])))
  expect_false(any(grepl("NANA.", leaders[["ARCHIGOS"]])))
})
