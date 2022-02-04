# Test if states are correctly identified
data <- data.frame(title = c("Korea and Democratic People's Republic of Korea",
                             "Guinea Equatorial",
                             "Guinea",
                             "Republic germany",
                             "German Democratic Republic",
                             "Austria-Hungary and Hungary",
                             "Hungary and Austria",
                             "East Pakistan",
                             "Pakistan",
                             "The UK and US",
                             "USA and U.K.",
                             "UK/Uganda Treaty",
                             "UAE treaty",
                             "U.A.E.",
                             "Great Colombia",
                             "Gran Colombia",
                             "The US and EU",
                             "The US and E.U.",
                             "South Georgia",
                             "British east africa",
                             "Belgian luxembourg",
                             "s. africa",
                             "south-africa",
                             "Northern rhodesia"))

test_that("states are given the correct label", {
 expect_equal(code_states(data$title, abbrev=TRUE), c("KOR_PRK", "GNQ", "GIN", "DEU", "DDR", "AUH_HUN", "AUT_HUN", "BGD", "PAK",
                                         "GBR_USA", "GBR_USA", "GBR_UGA", "ARE", "ARE", "GCL", "GCL",
                                         "EUE_USA", "EUE_USA", NA, "KEN", "BEL", "ZAF", "ZAF", "ZMB"))
})
