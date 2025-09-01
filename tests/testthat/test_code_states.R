states_test <- read.csv(paste0(testthat::test_path(), "/ctry_orig2ctry_pref.csv"),
                        encoding = "UTF-8")
states_test <- subset(states_test, nchar(ctry_orig) > 3)
states_test <- subset(states_test, ctry_orig != "EURATOM")
accents <- subset(states_test, stringi::stri_detect_regex(states_test$ctry_orig, "ã|é|è|ï|ü|ô"))

test_that("code_states works", {
  stts <- states_test[is.na(code_states(states_test$ctry_orig)),1]
  expect_equal(stts, vector("character"))
})

test_that("code_states works with non-ascii characters", {
  expect_equal(code_states(accents$ctry_orig, code = F),
               code_states(accents$ctry_pref, code = F))
})

test_that("state codes are 3 characters or less", {
  expect_false(any(nchar(code_states()$stateID) > 3))
})

test_that("state codes are all upper case", {
  expect_equal(code_states()$stateID, toupper(code_states()$stateID))
})

test_that("state codes are unique", {
  expect_false(any(duplicated(code_states()$stateID)))
})
