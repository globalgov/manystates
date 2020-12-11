library(pointblank)

test_that("object is correct", {
  expect_col_exists(ISD, vars(endsWith("ID")))
  expect_col_exists(ISD, vars(Beg))
  expect_col_exists(ISD, vars(End))
})

test_that("missing obsevarsions are reported correctly", {
  expect_length(grepl("-", ISD), 0)
  expect_length(grepl("n/a", ISD), 0)
  expect_length(grepl("N/A", ISD), 0)
})
