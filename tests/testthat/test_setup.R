library(testthat)
library(seirR)
library(readxl)
library(dplyr)

context("Testing package seirR")

test_that("Unmitigated Vensim Benchmark file available ...", {
 expect_true(exists("vensim_test_unmitigated"))
})

test_that("Mitigated Vensim Benchmark file available ...", {
  expect_true(exists("vensim_test_mitigated"))
})

test_that("Create an SEIR S3 object ...", {
  mod <- create_seir()
  expect_true(class(mod)[1]=="seir")
})

test_that("Check that a tibble is returned...", {
  mod <- create_seir()
  o <- run(mod)
  expect_true(class(o)[1]=="tbl_df")
})


