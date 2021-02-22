# Test if  meets the q ecosystem requirements

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
  expect_col_exists(states[["COW"]], vars(ID))
  expect_col_exists(states[["COW"]], vars(Beg))
  expect_col_exists(states[["COW"]], vars(End))
  expect_col_exists(states[["COW"]], vars(Label))
})

# Variables with dates are standardized
test_that("dates are standardised", {
  expect_col_is_date(states[["COW"]], vars(Beg))
  expect_col_is_date(states[["COW"]], vars(End))
  expect_false(any(grepl("/", states[["COW"]]$Beg)))
  expect_false(any(grepl("/", states[["COW"]]$End)))
})

# Labels are standardized
test_that("labels are standardised", {
  expect_false(any(grepl("U.S.", states[["COW"]])))
  expect_false(any(grepl("U.K.", states[["COW"]])))
  expect_false(any(grepl("!", states[["COW"]])))
  expect_false(any(grepl("NANA.", states[["COW"]])))
})
