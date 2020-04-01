library(testthat)
library(seirR)
library(readxl)
library(dplyr)

context("Testing package seirR...")

test_that("Unmitigated Vensim Benchmark file available ...", {
 expect_true(exists("test_unmitigated"))
})

test_that("Mitigated Vensim Benchmark file available ...", {
  expect_true(exists("test_mitigated"))
})

test_that("Create an SEIR Population S3 object ...", {
  mod <- create_seir_p()
  expect_true(class(mod)[1]=="seir_p")
})

test_that("Check that a tibble is returned...", {
  mod <- create_seir_p()
  o <- run(mod)
  expect_true(class(o)[1]=="tbl_df")
})

mod <- create_seir_p()
o_unmit <- run(mod,return_all = T)

test_that("Check Total Infectious (Unmitigated) ...", {
  expect_true(all.equal(o_unmit$TotalInfectious,
                        test_unmitigated$`Total Infectious`,
                        tolerance = .0001))
})

test_that("Check Total Exposed (Unmitigated) ...", {
  expect_true(all.equal(o_unmit$TotalExposed,test_unmitigated$`Total Exposed`,tolerance = .0001))
})

test_that("Check Total Removed (Unmitigated) ...", {
  expect_true(all.equal(o_unmit$TotalRemoved,test_unmitigated$`Total Removed`,tolerance = .0001))
})

mod <- set_param(mod,"distancing_flag",1)
o_mit <- run(mod,return_all = T)

test_that("Check Total Infectious (Mitigated) ...", {
  expect_true(all.equal(o_mit$TotalInfectious,test_mitigated$`Total Infectious`,tolerance = .0001))
})

test_that("Check Total Exposed (Mitigated) ...", {
  expect_true(all.equal(o_mit$TotalExposed,test_mitigated$`Total Exposed`,tolerance = .0001))
})

test_that("Check Total Removed (Mitigated) ...", {
  expect_true(all.equal(o_mit$TotalRemoved,test_mitigated$`Total Removed`,tolerance = .0001))
})

