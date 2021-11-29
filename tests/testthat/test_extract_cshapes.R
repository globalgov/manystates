# Test if import_cshapes() meets the manyverse requirements

test <- import_cshapes(date = "1900-01-01")
test2 <- import_distlist(date = "1900-01-01", type = "capdist")
test3 <- import_distmatrix(date = "1900-01-01", type = "capdist")

test_that("CShapes extraction returns qConsistent object", {
  expect_false(any(grepl("^n/a$", test)))
  expect_false(any(grepl("^N/A$", test)))
  expect_false(any(grepl("^\\s$", test)))
  expect_false(any(grepl("^\\.$", test2)))
  expect_false(any(grepl("N\\.A\\.$", test2)))
  expect_false(any(grepl("n\\.a\\.$", test2)))
})

test_that("object has the correct variables", {
  expect_col_exists(test, vars(COW_Nr))
  expect_col_exists(test, vars(Beg))
  expect_col_exists(test, vars(End))
  expect_col_exists(test, vars(Label))
  expect_col_exists(test2, vars(Distance))
})

test_that("Columns with dates are standardized", {
  expect_false(any(grepl("/", test[["Beg"]])))
  expect_false(any(grepl("^[:alpha:]$",
                         test[["Beg"]])))
  expect_false(any(grepl("^[:digit:]{1}$",
                         test[["Beg"]])))
})

test_that("Distances are standardised", {
  expect_true(is.numeric(test2$Distance))
})

test_that("Matrix has the correct format", {
  expect_true(is.matrix(test3))
})
