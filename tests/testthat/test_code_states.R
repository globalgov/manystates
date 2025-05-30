states_test <- read.csv(paste0(testthat::test_path(), "/ctry_orig2ctry_pref.csv"),
                        encoding = "UTF-8")
states_test <- dplyr::as_tibble(states_test)
states_test <- dplyr::filter(states_test, 
                             nchar(ctry_orig) > 2)
test_that("code_states works", {
  expect_equal(sum(is.na(code_states(states_test$ctry_orig))), 0)
})
# states_test[is.na(code_states(states_test$ctry_orig)),] %>% print(n = 30)
