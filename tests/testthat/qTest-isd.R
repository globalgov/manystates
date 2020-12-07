library(pointblank)

test_that("object is correct", {
  expect_col_exists(isd, vars(endsWith("ID")))
  expect_col_exists(isd, vars(Beg))
  expect_col_exists(isd, vars(End))
})

test_that("missing obsevarsions are reported correctly", {
  expect_length(grepl("-", isd), 0)
  expect_length(grepl("n/a", isd), 0)
  expect_length(grepl("N/A", isd), 0)
})
