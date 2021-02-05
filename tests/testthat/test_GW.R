# Test if  meets the q ecosystem requirements

# Requires the following package
library(pointblank)

# Report missing values 
test_that("missing observations are reported correctly", {
  expect_false(any(grepl("^.$", states[["GW"]])))
  expect_false(any(grepl("^n/a$", states[["GW"]])))
  expect_false(any(grepl("^N/A$", states[["GW"]])))
})

# Contains the required variables
test_that("object has the correct variables", {
  expect_col_exists(states[["GW"]], vars(ID))
  expect_col_exists(states[["GW"]], vars(Beg))
  expect_col_exists(states[["GW"]], vars(End))
  expect_col_exists(states[["GW"]], vars(Label))
})

# Variables with dates are standardized
test_that("dates are standardised", {
  expect_col_is_date(states[["GW"]], vars(Beg))
  expect_col_is_date(states[["GW"]], vars(End))
  expect_false(any(grepl("/", states[["GW"]]$Beg)))
  expect_false(any(grepl("/", states[["GW"]]$End)))
})

# Labels are standardized
test_that("labels are standardised", {
  expect_false(any(grepl("U.S.", states[["GW"]])))
  expect_false(any(grepl("U.K.", states[["GW"]])))
  expect_false(any(grepl("!", states[["GW"]])))
  expect_false(any(grepl("NANA.", states[["GW"]])))
})
