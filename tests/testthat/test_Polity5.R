# Test if the dataset meets the many packages universe requirements

test_that("missing observations are reported correctly", {
  expect_false(any(grepl("^n/a$", regimes[["Polity5"]])))
  expect_false(any(grepl("^N/A$", regimes[["Polity5"]])))
  expect_false(any(grepl("^\\s$", regimes[["Polity5"]])))
  expect_false(any(grepl("^\\.$", regimes[["Polity5"]])))
  expect_false(any(grepl("N\\.A\\.$", regimes[["Polity5"]])))
  expect_false(any(grepl("n\\.a\\.$", regimes[["Polity5"]])))
})

# Date columns should be in messydt class
test_that("Columns are not in date, POSIXct or POSIXlt class", {
  expect_false(any(lubridate::is.Date(regimes[["Polity5"]])))
  expect_false(any(lubridate::is.POSIXct(regimes[["Polity5"]])))
  expect_false(any(lubridate::is.POSIXlt(regimes[["Polity5"]])))
})

test_that("Columns with dates are standardized", {
  expect_equal(class(regimes[["Polity5"]]$Beg), "messydt")
  expect_false(any(grepl("/", regimes[["Polity5"]]$Beg)))
  expect_false(any(grepl("^[:alpha:]$",
                         regimes[["Polity5"]]$Beg)))
  expect_false(any(grepl("^[:digit:]{2}$",
                         regimes[["Polity5"]]$Beg)))
  expect_false(any(grepl("^[:digit:]{3}$",
                         regimes[["Polity5"]]$Beg)))
  expect_false(any(grepl("^[:digit:]{1}$",
                         regimes[["Polity5"]]$Beg)))
})

# Contains the required variables
test_that("object has the correct variables", {
  pointblank::expect_col_exists(regimes[["Polity5"]],
                                pointblank::vars(ID))
  expect_true(is.character(regimes[["Polity5"]][["ID"]]))
  pointblank::expect_col_exists(regimes[["Polity5"]],
                                pointblank::vars(COW_ID))
  pointblank::expect_col_exists(regimes[["Polity5"]],
                                pointblank::vars(Beg))
  pointblank::expect_col_exists(regimes[["Polity5"]],
                                pointblank::vars(End))
  pointblank::expect_col_exists(regimes[["Polity5"]],
                                pointblank::vars(Label))
})

# Labels are standardized
test_that("labels are standardised", {
  expect_false(any(grepl("U\\.S\\.", regimes[["Polity5"]])))
  expect_false(any(grepl("U.K.", regimes[["Polity5"]])))
  expect_false(any(grepl("!", regimes[["Polity5"]])))
  expect_false(any(grepl("NANA.", regimes[["Polity5"]])))
})
