# Test states database

# These tests can be run any at any time to check data consistency using the keyboard shortcut Cmd/Ctrl-Shift-T.
# We use the pointblank package to support testing.
library(pointblank)

test_that("object is correct", {
  expect_true(is.list(states))
  expect_true("COW" %in% names(states))
  expect_true("GW" %in% names(states))
  expect_true("ISD" %in% names(states))
})

# Uniformity tests (countries have a string ID, a beginning and an end of tenure as well as a name.)
test_that("datasets have the correct variables", {
  expect_col_exists(states[["COW"]], vars(ID))
  expect_col_exists(states[["COW"]], vars(Beg))
  expect_col_exists(states[["COW"]], vars(End))
  expect_col_exists(states[["COW"]], vars(Label))
  expect_col_exists(states[["GW"]], vars(ID))
  expect_col_exists(states[["GW"]], vars(Beg))
  expect_col_exists(states[["GW"]], vars(End))
  expect_col_exists(states[["GW"]], vars(Label))
  expect_col_exists(states[["ISD"]], vars(ID))
  expect_col_exists(states[["ISD"]], vars(Beg))
  expect_col_exists(states[["ISD"]], vars(End))
  expect_col_exists(states[["ISD"]], vars(Label))
})

test_that("missing observations are reported correctly", {
  expect_false(any(grepl("^.$", states[["COW"]])))
  expect_false(any(grepl("^n/a$", states[["COW"]])))
  expect_false(any(grepl("^N/A$", states[["COW"]])))
  expect_false(any(grepl("^.$", states[["GW"]])))
  expect_false(any(grepl("^n/a$", states[["GW"]])))
  expect_false(any(grepl("^N/A$", states[["GW"]])))
  expect_false(any(grepl("^.$", states[["ISD"]])))
  expect_false(any(grepl("^n/a$", states[["ISD"]])))
  expect_false(any(grepl("^N/A$", states[["ISD"]])))
})

test_that("dates are standardised", {
  expect_true(messydates::is_messydate(states[["COW"]][["Beg"]]))
  expect_true(messydates::is_messydate(states[["COW"]][["End"]]))
  expect_false(any(grepl("/", states[["COW"]]$Beg)))
  expect_false(any(grepl("/", states[["COW"]]$End)))
  expect_true(messydates::is_messydate(states[["COW"]][["Beg"]]))
  expect_true(messydates::is_messydate(states[["COW"]][["End"]]))
  expect_false(any(grepl("/", states[["GW"]]$Beg)))
  expect_false(any(grepl("/", states[["GW"]]$End)))
  expect_true(messydates::is_messydate(states[["COW"]][["Beg"]]))
  expect_true(messydates::is_messydate(states[["COW"]][["End"]]))
  expect_false(any(grepl("/", states[["ISD"]]$Beg)))
  expect_false(any(grepl("/", states[["ISD"]]$End)))
})
# # 
# # # More restrictive test that ensure dates are also in the correct format
# # # #Set up a date checking function. Takes a vector and a date format as inputs (source: https://gist.github.com/micstr/69a64fbd0f5635094a53)
# # # is_date = function(x, format) {
# # #   formatted = try(as.Date(x, format), silent = TRUE)
# # #   return(as.character(formatted) == x)
# # # }
# # # 
# # # #Setting the YMD format
# # # date_format = "%Y-%m-%d"
# # # 
# # # #Running the tests on the list of dataframes that the export data function created.(source for syntax: https://stackoverflow.com/questions/47443365/how-to-extract-certain-columns-from-a-list-of-data-frames)
# # # test_that("dates are in the correct format (ymd)", {
# # #   expect_equal(is_date(states[[{{{dat}}}]][, "Beg"], date_format),TRUE)
# # #   expect_equal(is_date(states[[{{{dat}}}]][, "End"], date_format),TRUE)
# # # })
# # 
# Tests that the labels are standardized
test_that("labels are standardised", {
  expect_false(any(grepl("U.S.", states[["COW"]])))
  expect_false(any(grepl("U.K.", states[["COW"]])))
  expect_false(any(grepl("!", states[["COW"]])))
  expect_false(any(grepl("NANA.", states[["COW"]])))
  expect_false(any(grepl("U.S.", states[["GW"]])))
  expect_false(any(grepl("U.K.", states[["GW"]])))
  expect_false(any(grepl("!", states[["GW"]])))
  expect_false(any(grepl("NANA.", states[["GW"]])))
  expect_false(any(grepl("U.S.", states[["ISD"]])))
  expect_false(any(grepl("U.K.", states[["ISD"]])))
  expect_false(any(grepl("!", states[["ISD"]])))
  expect_false(any(grepl("NANA.", states[["ISD"]])))
})
