# Test if the dataset meets the many packages universe requirements

# Report missing values
test_that("missing observations are reported correctly", {
  expect_false(any(grepl("^n/a$", states[["HUGGO"]])))
  expect_false(any(grepl("^N/A$", states[["HUGGO"]])))
  expect_false(any(grepl("^\\s$", states[["HUGGO"]])))
  expect_false(any(grepl("^\\.$", states[["HUGGO"]])))
  expect_false(any(grepl("N\\.A\\.$", states[["HUGGO"]])))
  expect_false(any(grepl("n\\.a\\.$", states[["HUGGO"]])))
})

# Date columns should be in mdate class
# test_that("Columns are not in date, POSIXct or POSIXlt class", {
#   expect_false(any(lubridate::is.Date(states[["HUGGO"]])))
#   expect_false(any(lubridate::is.POSIXct(states[["HUGGO"]])))
#   expect_false(any(lubridate::is.POSIXlt(states[["HUGGO"]])))
# })

# Contains the required variables
test_that("object has the correct variables", {
  pointblank::expect_col_exists(states[["HUGGO"]],
                                pointblank::vars(stateID))
  pointblank::expect_col_exists(states[["HUGGO"]],
                                pointblank::vars(Begin))
  pointblank::expect_col_exists(states[["HUGGO"]],
                                pointblank::vars(End))
  pointblank::expect_col_exists(states[["HUGGO"]],
                                pointblank::vars(StateName))
})

# Variables with dates are standardized
test_that("dates are standardised", {
  expect_s3_class(states[["HUGGO"]]$Begin, "mdate")
  expect_s3_class(states[["HUGGO"]]$End, "mdate")
  expect_false(any(grepl("/", states[["HUGGO"]]$Begin)))
  expect_false(any(grepl("/", states[["HUGGO"]]$End)))
})

# Labels are standardized
test_that("labels are standardised", {
  expect_false(any(grepl("U\\.S\\.", states[["HUGGO"]])))
  expect_false(any(grepl("U\\.K\\.", states[["HUGGO"]])))
  # expect_false(any(grepl("!", states[["HUGGO"]])))
  expect_false(any(grepl("NANA.", states[["HUGGO"]])))
})

test_that("state codes pick up all HUGGO stateIDs uniquely", {
  huggo_state_id <- code_states(states$HUGGO$StateName, max_count = 2)
  expect_equal(states$HUGGO$StateName[is.na(huggo_state_id)], character(0))
  expect_equal(paste(states$HUGGO$StateName[grepl(",",huggo_state_id)], 
                     huggo_state_id[grepl(",",huggo_state_id)]), 
               character(0))
})

