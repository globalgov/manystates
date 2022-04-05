# Test if import_cshapes() meets the many universe requirements

test <- import_cshapes(date = "1900-01-01")
test2 <- import_distlist(date = "1900-01-01", type = "capdist")
test2min <- import_distlist(date = "1900-01-01", type = "mindist")
# test2cent <- import_distlist(date = "2010-01-01", type = "centdist")
test3 <- import_distmatrix(date = "1900-01-01", type = "capdist")

test_that("CShapes extraction returns many-package consistent object", {
  expect_false(any(grepl("^n/a$", test)))
  expect_false(any(grepl("^N/A$", test)))
  expect_false(any(grepl("^\\s$", test)))
  expect_false(any(grepl("^\\.$", test2)))
  expect_false(any(grepl("N\\.A\\.$", test2)))
  expect_false(any(grepl("n\\.a\\.$", test2)))
})

test_that("object has the correct variables", {
  pointblank::expect_col_exists(test,
                                pointblank::vars(COW_ID))
  pointblank::expect_col_exists(test,
                                pointblank::vars(Beg))
  pointblank::expect_col_exists(test,
                                pointblank::vars(End))
  pointblank::expect_col_exists(test,
                                pointblank::vars(Label))
  pointblank::expect_col_exists(test2,
                                pointblank::vars(Distance))
  pointblank::expect_col_exists(test2min,
                                pointblank::vars(Distance))
  # pointblank::expect_col_exists(test2cent,
  #                               pointblank::vars(Distance))
})

test_that("Columns with dates are standardized", {
  expect_false(any(grepl("/", test[["Beg"]])))
  expect_false(any(grepl("^[:alpha:]$",
                         test[["Beg"]])))
  expect_false(any(grepl("^[:digit:]{1}$",
                         test[["Beg"]])))
  expect_false(any(grepl("/", test2[["Beg"]])))
  expect_false(any(grepl("^[:alpha:]$",
                         test2[["Beg"]])))
  expect_false(any(grepl("^[:digit:]{1}$",
                         test2[["Beg"]])))
  expect_false(any(grepl("/", test2min[["Beg"]])))
  expect_false(any(grepl("^[:alpha:]$",
                         test2min[["Beg"]])))
  expect_false(any(grepl("^[:digit:]{1}$",
                         test2min[["Beg"]])))
})

test_that("Distances are standardised", {
  expect_true(is.numeric(test2$Distance))
  expect_true(is.numeric(test2min$Distance))
  # expect_true(is.numeric(test2cent$Distance))
})

test_that("Matrix has the correct format", {
  expect_true(is.matrix(test3))
})

test_that("Dates outside data range throw error", {
  expect_error(import_cshapes("1885-01-01"))
  expect_error(import_distlist("1885-01-01"))
  expect_error(import_distmatrix("1885-01-01"))
})

test_that("Type outside data range throw error", {
  expect_error(import_distlist("1885-01-01", type = "maxdist"))
  expect_error(import_distmatrix("1885-01-01", type = "maxdist"))
})