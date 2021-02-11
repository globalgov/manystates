# Test if  meets the q ecosystem requirements

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
  expect_col_exists(states[["ISD"]], vars(ID))
  expect_col_exists(states[["ISD"]], vars(Beg))
  expect_col_exists(states[["ISD"]], vars(End))
  expect_col_exists(states[["ISD"]], vars(Label))
})

# Variables with dates are standardized
test_that("dates are standardised", {
  expect_col_is_date(states[["ISD"]], vars(Beg))
  expect_col_is_date(states[["ISD"]], vars(End))
  expect_false(any(grepl("/", states[["ISD"]]$Beg)))
  expect_false(any(grepl("/", states[["ISD"]]$End)))
})

# Labels are standardized
test_that("labels are standardised", {
  expect_false(any(grepl("U.S.", states[["ISD"]])))
  expect_false(any(grepl("U.K.", states[["ISD"]])))
  expect_false(any(grepl("!", states[["ISD"]])))
  expect_false(any(grepl("NANA.", states[["ISD"]])))
})
