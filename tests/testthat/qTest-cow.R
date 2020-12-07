library(pointblank)

test_that("object is correct", {
  expect_col_exists(cow, vars(endsWith("ID")))
  expect_col_exists(cow, vars(Beg))
  expect_col_exists(cow, vars(End))
})

test_that("missing obsevarsions are reported correctly", {
  expect_length(grepl("-", cow), 0)
  expect_length(grepl("n/a", cow), 0)
  expect_length(grepl("N/A", cow), 0)
})
