test_that("generate_states works", {
  expect_equal(length(generate_states(50)), 50)
  expect_false(any(duplicated(generate_states(50))))
})
