# Test if the dataset meets the many packages universe requirements

# Report missing values
test_that("missing observations are reported correctly", {
  expect_false(any(grepl("\\?", states[["ISD"]])))
  expect_false(any(grepl("^n/a$", states[["ISD"]])))
  expect_false(any(grepl("^N/A$", states[["ISD"]])))
  expect_false(any(grepl("^\\s$", states[["ISD"]])))
  expect_false(any(grepl("^\\.$", states[["ISD"]])))
  expect_false(any(grepl("N\\.A\\.$", states[["ISD"]])))
  expect_false(any(grepl("n\\.a\\.$", states[["ISD"]])))
})

# Contains the required variables
test_that("object has the correct variables", {
  pointblank::expect_col_exists(states[["ISD"]],
                                pointblank::vars(COW_ID))
  pointblank::expect_col_exists(states[["ISD"]],
                                pointblank::vars(Beg))
  pointblank::expect_col_exists(states[["ISD"]],
                                pointblank::vars(End))
  pointblank::expect_col_exists(states[["ISD"]],
                                pointblank::vars(Label))
})

# Variables with dates are standardized
test_that("Columns with dates are standardized", {
  expect_equal(class(states[["ISD"]]$Beg), "messydt")
  expect_false(any(grepl("/", states[["ISD"]]$Beg)))
  expect_false(any(grepl("^[:alpha:]$",
                         states[["ISD"]]$Beg)))
  expect_false(any(grepl("^[:digit:]{2}$",
                         states[["ISD"]]$Beg)))
  expect_false(any(grepl("^[:digit:]{3}$",
                         states[["ISD"]]$Beg)))
  expect_false(any(grepl("^[:digit:]{1}$",
                         states[["ISD"]]$Beg)))
})

# Labels are standardized
test_that("labels are standardised", {
  expect_false(any(grepl("U\\.S\\.", states[["ISD"]])))
  expect_false(any(grepl("U.K.", states[["ISD"]])))
  expect_false(any(grepl("!", states[["ISD"]])))
  expect_false(any(grepl("NANA.", states[["ISD"]])))
})
