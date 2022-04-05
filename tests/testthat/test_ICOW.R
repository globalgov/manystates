# Test if the dataset meets the many packages universe requirements

# Report missing values
test_that("missing observations are reported correctly", {
  # expect_false(any(grepl("\\?", states[["ICOW"]]))) # There are ? in notes var
  expect_false(any(grepl("^n/a$", states[["ICOW"]])))
  expect_false(any(grepl("^N/A$", states[["ICOW"]])))
  expect_false(any(grepl("^\\s$", states[["ICOW"]])))
  expect_false(any(grepl("^\\.$", states[["ICOW"]])))
  expect_false(any(grepl("N\\.A\\.$", states[["ICOW"]])))
  expect_false(any(grepl("n\\.a\\.$", states[["ICOW"]])))
})

# Contains the required variables
test_that("object has the correct variables", {
  pointblank::expect_col_exists(states[["ICOW"]],
                                pointblank::vars(COW_ID))
  pointblank::expect_col_exists(states[["ICOW"]],
                                pointblank::vars(IndFrom))
  pointblank::expect_col_exists(states[["ICOW"]],
                                pointblank::vars(IndDate))
  pointblank::expect_col_exists(states[["ICOW"]],
                                pointblank::vars(SecDate))
  pointblank::expect_col_exists(states[["ICOW"]],
                                pointblank::vars(COWsys))
  pointblank::expect_col_exists(states[["ICOW"]],
                                pointblank::vars(GWsys))
  pointblank::expect_col_exists(states[["ICOW"]],
                                pointblank::vars(Label))
})

# Variables with dates are standardized
test_that("Columns with dates are standardized", {
  expect_equal(class(states[["ICOW"]]$IndDate), "messydt")
  expect_equal(class(states[["ICOW"]]$SecDate), "messydt")
  expect_equal(class(states[["ICOW"]]$COWsys), "messydt")
  expect_equal(class(states[["ICOW"]]$GWsys), "messydt")
  expect_false(any(grepl("/", states[["ICOW"]]$IndDate)))
  expect_false(any(grepl("^[:alpha:]$",
                         states[["ICOW"]]$IndDate)))
  expect_false(any(grepl("^[:digit:]{2}$",
                         states[["ICOW"]]$IndDate)))
  expect_false(any(grepl("^[:digit:]{3}$",
                         states[["ICOW"]]$IndDate)))
  expect_false(any(grepl("^[:digit:]{1}$",
                         states[["ICOW"]]$IndDate)))
})

# Labels are standardized
test_that("labels are standardised", {
  expect_false(any(grepl("U\\.S\\.", states[["ICOW"]])))
  expect_false(any(grepl("U.K.", states[["ICOW"]])))
  expect_false(any(grepl("!", states[["ICOW"]])))
  expect_false(any(grepl("NANA.", states[["ICOW"]])))
})
