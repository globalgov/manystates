library(pointblank)

test_that("object is correct", {
  expect_col_exists(gwstates, vars(endsWith("ID")))
  expect_col_exists(qwstates, vars(Beg))
  expect_col_exists(gwstates, vars(End))
})

