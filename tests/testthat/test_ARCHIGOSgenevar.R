# Test if  meets the q ecosystem requirements

# Report missing values
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
