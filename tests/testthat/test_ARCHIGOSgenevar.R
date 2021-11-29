# Test if the dataset meets the manyverse requirements

test_that("missing observations are reported correctly", {
  expect_false(any(grepl("^n/a$", genevar[["ARCHIGOSgenevar"]])))
  expect_false(any(grepl("^N/A$", genevar[["ARCHIGOSgenevar"]])))
  expect_false(any(grepl("^\\s$", genevar[["ARCHIGOSgenevar"]])))
  expect_false(any(grepl("^\\.$", genevar[["ARCHIGOSgenevar"]])))
  expect_false(any(grepl("N\\.A\\.$", genevar[["ARCHIGOSgenevar"]])))
  expect_false(any(grepl("n\\.a\\.$", genevar[["ARCHIGOSgenevar"]])))
})

# Date columns should be in messydt class
test_that("Columns are not in date, POSIXct or POSIXlt class", {
  expect_false(any(lubridate::is.Date(genevar[["ARCHIGOSgenevar"]])))
  expect_false(any(lubridate::is.POSIXct(genevar[["ARCHIGOSgenevar"]])))
  expect_false(any(lubridate::is.POSIXlt(genevar[["ARCHIGOSgenevar"]])))
})

test_that("Columns with dates are standardized", {
  expect_equal(class(genevar[["ARCHIGOSgenevar"]]$Beg), "messydt")
  expect_false(any(grepl("/", genevar[["ARCHIGOSgenevar"]]$Beg)))
  expect_false(any(grepl("^[:alpha:]$",
                         genevar[["ARCHIGOSgenevar"]]$Beg)))
  expect_false(any(grepl("^[:digit:]{2}$",
                         genevar[["ARCHIGOSgenevar"]]$Beg)))
  expect_false(any(grepl("^[:digit:]{3}$",
                         genevar[["ARCHIGOSgenevar"]]$Beg)))
  expect_false(any(grepl("^[:digit:]{1}$",
                         genevar[["ARCHIGOSgenevar"]]$Beg)))
})

# Contains the required variables
test_that("object has the correct variables", {
  expect_col_exists(genevar[["ARCHIGOSgenevar"]], vars(ID))
  expect_col_exists(genevar[["ARCHIGOSgenevar"]], vars(Beg))
  expect_col_exists(genevar[["ARCHIGOSgenevar"]], vars(End))
  expect_col_exists(genevar[["ARCHIGOSgenevar"]], vars(Label))
})

# Labels are standardized
test_that("labels are standardised", {
  expect_false(any(grepl("U.S.", genevar[["ARCHIGOSgenevar"]])))
  expect_false(any(grepl("U.K.", genevar[["ARCHIGOSgenevar"]])))
  expect_false(any(grepl("!", genevar[["ARCHIGOSgenevar"]])))
  expect_false(any(grepl("NANA.", genevar[["ARCHIGOSgenevar"]])))
})
