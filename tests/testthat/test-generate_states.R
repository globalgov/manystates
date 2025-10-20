test_that("generate_states works", {
  expect_equal(length(generate_states(5)), 5)
  expect_false(any(duplicated(generate_states(50))))
})
