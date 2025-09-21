# Test if the dataset meets the many packages universe requirements

# Report missing values
test_that("missing observations are reported correctly", {
  expect_false(any(grepl("^n/a$", states[["GGO"]])))
  expect_false(any(grepl("^N/A$", states[["GGO"]])))
  expect_false(any(grepl("^\\s$", states[["GGO"]])))
  expect_false(any(grepl("^\\.$", states[["GGO"]])))
  expect_false(any(grepl("N\\.A\\.$", states[["GGO"]])))
  expect_false(any(grepl("n\\.a\\.$", states[["GGO"]])))
})

# Date columns should be in mdate class
# test_that("Columns are not in date, POSIXct or POSIXlt class", {
#   expect_false(any(lubridate::is.Date(states[["GGO"]])))
#   expect_false(any(lubridate::is.POSIXct(states[["GGO"]])))
#   expect_false(any(lubridate::is.POSIXlt(states[["GGO"]])))
# })

# Contains the required variables
test_that("object has the correct variables", {
  pointblank::expect_col_exists(states[["GGO"]],
                                pointblank::vars(stateID))
  pointblank::expect_col_exists(states[["GGO"]],
                                pointblank::vars(Begin))
  pointblank::expect_col_exists(states[["GGO"]],
                                pointblank::vars(End))
  pointblank::expect_col_exists(states[["GGO"]],
                                pointblank::vars(StateName))
})

# Variables with dates are standardized
test_that("dates are standardised", {
  expect_s3_class(states[["GGO"]]$Begin, "mdate")
  expect_s3_class(states[["GGO"]]$End, "mdate")
  expect_false(any(grepl("/", states[["GGO"]]$Begin)))
  expect_false(any(grepl("/", states[["GGO"]]$End)))
})

# Labels are standardized
test_that("labels are standardised", {
  expect_false(any(grepl("U\\.S\\.", states[["GGO"]])))
  expect_false(any(grepl("U\\.K\\.", states[["GGO"]])))
  # expect_false(any(grepl("!", states[["GGO"]])))
  expect_false(any(grepl("NANA.", states[["GGO"]])))
})

test_that("state codes pick up all GGO stateIDs uniquely", {
  GGO_state_id <- code_states(states$GGO$StateName, max_count = 2)
  expect_equal(states$GGO$StateName[is.na(GGO_state_id)], character(0))
  expect_equal(paste(states$GGO$StateName[grepl(",",GGO_state_id)], 
                     GGO_state_id[grepl(",",GGO_state_id)]), 
               character(0))
})

