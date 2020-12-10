library(pointblank)

test_that("object is correct", {
  expect_col_exists(GW, vars(endsWith("ID")))
  expect_col_exists(GW, vars(Beg))
  expect_col_exists(GW, vars(End))
})

test_that("missing obsevarsions are reported correctly", {
  expect_length(grepl("-", GW), 0)
  expect_length(grepl("n/a", GW), 0)
  expect_length(grepl("N/A", GW), 0)
})
