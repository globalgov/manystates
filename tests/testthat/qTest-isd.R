library(pointblank)

test_that("object is correct", {
  expect_col_exists(isd, vars(endsWith("ID")))
  expect_col_exists(isd, vars(Beg))
  expect_col_exists(isd, vars(End))
})

