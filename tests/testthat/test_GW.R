# Test if the dataset meets the many universe requirements

# Report missing values
test_that("missing observations are reported correctly", {
  expect_false(any(grepl("\\?", states[["GW"]])))
  expect_false(any(grepl("^n/a$", states[["GW"]])))
  expect_false(any(grepl("^N/A$", states[["GW"]])))
  expect_false(any(grepl("^\\s$", states[["GW"]])))
  expect_false(any(grepl("^\\.$", states[["GW"]])))
  expect_false(any(grepl("N\\.A\\.$", states[["GW"]])))
  expect_false(any(grepl("n\\.a\\.$", states[["GW"]])))
})

# Contains the required variables
test_that("object has the correct variables", {
  expect_col_exists(states[["GW"]], vars(ID))
  expect_col_exists(states[["GW"]], vars(Beg))
  expect_col_exists(states[["GW"]], vars(End))
  expect_col_exists(states[["GW"]], vars(Label))
})

# Variables with dates are standardized
test_that("Columns with dates are standardized", {
  expect_equal(class(states[["GW"]]$Beg), "messydt")
  expect_false(any(grepl("/", states[["GW"]]$Beg)))
  expect_false(any(grepl("^[:alpha:]$",
                        states[["GW"]]$Beg)))
  expect_false(any(grepl("^[:digit:]{2}$",
                         states[["GW"]]$Beg)))
  expect_false(any(grepl("^[:digit:]{3}$",
                         states[["GW"]]$Beg)))
  expect_false(any(grepl("^[:digit:]{1}$",
                         states[["GW"]]$Beg)))
})

# Labels are standardized
test_that("labels are standardised", {
  expect_false(any(grepl("U.S.", states[["GW"]])))
  expect_false(any(grepl("U.K.", states[["GW"]])))
  expect_false(any(grepl("!", states[["GW"]])))
  expect_false(any(grepl("NANA.", states[["GW"]])))
})
