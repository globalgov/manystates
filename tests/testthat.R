Sys.setenv("R_TESTS" = "")
library(testthat)
library(pointblank)
library(qStates)

test_check("qStates")
