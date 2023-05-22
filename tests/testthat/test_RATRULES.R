# Test if the dataset meets the many packages universe requirements

# Report missing values
test_that("missing observations are reported correctly", {
  expect_false(any(grepl("\\?", states[["RATRULES"]])))
  expect_false(any(grepl("^n/a$", states[["RATRULES"]])))
  expect_false(any(grepl("^N/A$", states[["RATRULES"]])))
  expect_false(any(grepl("^\\s$", states[["RATRULES"]])))
  expect_false(any(grepl("^\\.$", states[["RATRULES"]])))
  expect_false(any(grepl("N\\.A\\.$", states[["RATRULES"]])))
  expect_false(any(grepl("n\\.a\\.$", states[["RATRULES"]])))
})

# Date columns should be in mdate class
test_that("Columns are not in date, POSIXct or POSIXlt class", {
  expect_false(any(lubridate::is.Date(states[["RATRULES"]])))
  expect_false(any(lubridate::is.POSIXct(states[["RATRULES"]])))
  expect_false(any(lubridate::is.POSIXlt(states[["RATRULES"]])))
})

# Contains the required variables
test_that("object has the correct variables", {
  pointblank::expect_col_exists(states[["RATRULES"]],
                                pointblank::vars(stateID))
  pointblank::expect_col_exists(states[["RATRULES"]],
                                pointblank::vars(StateName))
})

# Labels are standardized
test_that("labels are standardised", {
  expect_false(any(grepl("U\\.S\\.", states[["RATRULES"]])))
  expect_false(any(grepl("U\\.K\\.", states[["RATRULES"]])))
  expect_false(any(grepl("!", states[["RATRULES"]])))
  expect_false(any(grepl("NANA.", states[["RATRULES"]])))
})
