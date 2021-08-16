# Test if  meets the q ecosystem requirements

# Report missing values
test_that("missing observations are reported correctly", {
  expect_false(any(grepl("^n/a$", regimes[["Polity5"]])))
  expect_false(any(grepl("^N/A$", regimes[["Polity5"]])))
  expect_false(any(grepl("^\\s$", regimes[["Polity5"]])))
  expect_false(any(grepl("^\\.$", regimes[["Polity5"]])))
  expect_false(any(grepl("N\\.A\\.$", regimes[["Polity5"]])))
  expect_false(any(grepl("n\\.a\\.$", regimes[["Polity5"]])))
})

# At least one column named ID
test_that("a column indicating an ID source exists", {
  expect_true(any(grepl("ID", colnames(regimes[["Polity5"]]))))
})

# Labels are standardized
test_that("labels are standardised", {
  expect_false(any(grepl("U\\.S\\.", regimes[["Polity5"]])))
  expect_false(any(grepl("U\\.K\\.", regimes[["Polity5"]])))
  expect_false(any(grepl("!", regimes[["Polity5"]])))
  expect_false(any(grepl("NANA.", regimes[["Polity5"]])))
})

# Dates are standardized
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
