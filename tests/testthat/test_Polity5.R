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
  if (!is.null(regimes[["Polity5"]]$Label)) {
  expect_false(any(grepl("U\\.S\\.", regimes[["Polity5"]])))
  expect_false(any(grepl("U\\.K\\.", regimes[["Polity5"]])))
  expect_false(any(grepl("!", regimes[["Polity5"]])))
  expect_false(any(grepl("NANA.", regimes[["Polity5"]])))
  }
})

# Dates are standardized
test_that("Columns with dates are standardized", {
  if (!is.null(regimes[["Polity5"]]$Beg)) {
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
  }
})

# Dataset should be ordered according to the "Beg" column
# if the column exists
#   test_that("dataset is arranged by date variable", {
#     if (!is.null(regimes[["Polity5"]]$Beg)) {
#   expect_true(regimes[["Polity5"]]$Beg[50] < regimes[["Polity5"]]$Beg[75])
#   expect_true(regimes[["Polity5"]]$Beg[100] < regimes[["Polity5"]]$Beg[120])
#     }
# })

# Commented out this test since it makes more sense to order by polity.
