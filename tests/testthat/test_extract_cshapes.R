test <- import_cshapes(date = "1900-01-01")

test_that("CShapes extraction returns qConsistent object", {
  expect_false(any(grepl("\\?", test)))
  expect_false(any(grepl("^n/a$", test)))
  expect_false(any(grepl("^N/A$", test)))
  expect_false(any(grepl("^\\s$", test)))
  expect_false(any(grepl("^\\.$", test)))
  expect_false(any(grepl("N\\.A\\.$", test)))
  expect_false(any(grepl("n\\.a\\.$", test)))
})

# Contains the required variables
test_that("object has the correct variables", {
  expect_col_exists(test, vars(COW_Nr))
  expect_col_exists(test, vars(Beg))
  expect_col_exists(test, vars(End))
  expect_col_exists(test, vars(Label))
})

# Variables with dates are standardized
test_that("dates are standardised", {
  expect_col_is_date(test, vars(Beg))
  expect_col_is_date(test, vars(End))
  expect_false(any(grepl("/", test$Beg)))
  expect_false(any(grepl("/", test$End)))
})

# Labels are standardized
test_that("labels are standardised", {
  expect_false(any(grepl("U.S.", test)))
  expect_false(any(grepl("U.K.", test)))
  expect_false(any(grepl("!", test)))
  expect_false(any(grepl("NANA.", test)))
})
