library(pointblank)

test_that("object is correct", {
  expect_col_exists(cow, vars(Beg))
  expect_col_exists(cow, vars(End))
})
