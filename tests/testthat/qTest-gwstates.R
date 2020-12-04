library(pointblank)

test_that("object is correct", {
  expect_col_exists(gwstates, vars(endsWith("ID")))
  expect_col_exists(gwstates, vars(Beg))
  expect_col_exists(gwstates, vars(End))
})

test_that("missing obsevarsions are reported correctly", {
  expect_length(grepl("-", gwstates), 0)
  expect_length(grepl("n/a", gwstates), 0)
  expect_length(grepl("N/A", gwstates), 0)
})
