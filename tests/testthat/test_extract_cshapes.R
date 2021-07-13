# Tests for import_cshapes() function -----------------------------------------
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
# Tests for import_distlist() function -----------------------------------------
test2 <- import_distlist(date = "1900-01-01", type = "capdist")

test_that("CShapes extraction returns qConsistent object", {
  expect_false(any(grepl("\\?", test2)))
  expect_false(any(grepl("^n/a$", test2)))
  expect_false(any(grepl("^N/A$", test2)))
  expect_false(any(grepl("^\\s$", test2)))
  expect_false(any(grepl("^\\.$", test2)))
  expect_false(any(grepl("N\\.A\\.$", test2)))
  expect_false(any(grepl("n\\.a\\.$", test2)))
})

# Contains the required variables
test_that("object has the correct variables", {
  expect_col_exists(test2, vars(FromLabel))
  expect_col_exists(test2, vars(ToLabel))
  expect_col_exists(test2, vars(FromCode))
  expect_col_exists(test2, vars(ToCode))
  expect_col_exists(test2, vars(Distance))
})

# Variables with dates are standardized
test_that("Distances are standardised", {
  expect_true(is.numeric(test2$Distance))
})

# Labels are standardized
test_that("labels are standardised", {
  expect_false(any(grepl("U.S.", test2)))
  expect_false(any(grepl("U.K.", test2)))
  expect_false(any(grepl("!", test2)))
  expect_false(any(grepl("NANA.", test2)))
})

# Tests for import_cshapes() function -----------------------------------------
test3 <- import_distmatrix(date = "1900-01-01", type = "capdist")

test_that("Matrix has the correct format", {
  expect_true(is.matrix(test3))
})

