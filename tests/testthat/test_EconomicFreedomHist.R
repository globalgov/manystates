# # Test if the dataset meets the many packages universe requirements
# 
# # Report missing values
# test_that("missing observations are reported correctly", {
#   expect_false(any(grepl("\\?", states[["EconomicFreedomHist"]])))
#   expect_false(any(grepl("^n/a$", states[["EconomicFreedomHist"]])))
#   expect_false(any(grepl("^N/A$", states[["EconomicFreedomHist"]])))
#   expect_false(any(grepl("^\\s$", states[["EconomicFreedomHist"]])))
#   expect_false(any(grepl("^\\.$", states[["EconomicFreedomHist"]])))
#   expect_false(any(grepl("N\\.A\\.$", states[["EconomicFreedomHist"]])))
#   expect_false(any(grepl("n\\.a\\.$", states[["EconomicFreedomHist"]])))
# })
# 
# # Date columns should be in mdate class
# test_that("Columns are not in date, POSIXct or POSIXlt class", {
#   expect_false(any(lubridate::is.Date(states[["EconomicFreedomHist"]])))
#   expect_false(any(lubridate::is.POSIXct(states[["EconomicFreedomHist"]])))
#   expect_false(any(lubridate::is.POSIXlt(states[["EconomicFreedomHist"]])))
# })
# 
# # Contains the required variables
# test_that("object has the correct variables", {
#   pointblank::expect_col_exists(states[["EconomicFreedomHist"]],
#                                 pointblank::vars(stateID))
#   pointblank::expect_col_exists(states[["EconomicFreedomHist"]],
#                                 pointblank::vars(StateName))
# })
# 
# # Variables with dates are standardized
# test_that("dates are standardised", {
#   expect_s3_class(states[["EconomicFreedomHist"]]$Year, "mdate")
#   expect_false(any(grepl("/", states[["EconomicFreedomHist"]]$Year)))
# })
# 
# # Labels are standardized
# test_that("labels are standardised", {
#   expect_false(any(grepl("U\\.S\\.", states[["EconomicFreedomHist"]])))
#   expect_false(any(grepl("U\\.K\\.", states[["EconomicFreedomHist"]])))
#   expect_false(any(grepl("!", states[["EconomicFreedomHist"]])))
#   expect_false(any(grepl("NANA.", states[["EconomicFreedomHist"]])))
# })
