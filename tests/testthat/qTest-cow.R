library(pointblank)

test_that("object is correct", {
  expect_col_exists(COW, vars(endsWith("ID")))
  expect_col_exists(COW, vars(Beg))
  expect_col_exists(COW, vars(End))
})

test_that("missing obsevarsions are reported correctly", {
  expect_length(grepl("-", COW), 0)
  expect_length(grepl("n/a", COW), 0)
  expect_length(grepl("N/A", COW), 0)
})
