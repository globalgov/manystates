# Test if the dataset meets the many packages universe requirements

# Report missing values
test_that("missing observations are reported correctly", {
  expect_false(any(grepl("\\?", states[["COW"]])))
  expect_false(any(grepl("^n/a$", states[["COW"]])))
  expect_false(any(grepl("^N/A$", states[["COW"]])))
  expect_false(any(grepl("^\\s$", states[["COW"]])))
  expect_false(any(grepl("^\\.$", states[["COW"]])))
  expect_false(any(grepl("N\\.A\\.$", states[["COW"]])))
  expect_false(any(grepl("n\\.a\\.$", states[["COW"]])))
})

# Contains the required variables
test_that("object has the correct variables", {
  pointblank::expect_col_exists(states[["COW"]],
                                pointblank::vars(COW_ID))
  pointblank::expect_col_exists(states[["COW"]],
                                pointblank::vars(Beg))
  pointblank::expect_col_exists(states[["COW"]],
                                pointblank::vars(End))
  pointblank::expect_col_exists(states[["COW"]],
                                pointblank::vars(Label))
})

# Variables with dates are standardized
test_that("Columns with dates are standardized", {
  expect_equal(class(states[["COW"]]$Beg), "mdate")
  expect_false(any(grepl("/", states[["COW"]]$Beg)))
  expect_false(any(grepl("^[:alpha:]$",
                         states[["COW"]]$Beg)))
  expect_false(any(grepl("^[:digit:]{2}$",
                         states[["COW"]]$Beg)))
  expect_false(any(grepl("^[:digit:]{3}$",
                         states[["COW"]]$Beg)))
  expect_false(any(grepl("^[:digit:]{1}$",
                         states[["COW"]]$Beg)))
})

# Labels are standardized
test_that("labels are standardised", {
  expect_false(any(grepl("U\\.S\\.", states[["COW"]])))
  expect_false(any(grepl("U.K.", states[["COW"]])))
  expect_false(any(grepl("!", states[["COW"]])))
  expect_false(any(grepl("NANA.", states[["COW"]])))
})
