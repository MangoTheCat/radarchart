context("runExampleApp")

test_that("None existant apps", {
  
  expect_error(runExampleApp("beans"))
  
  expect_error(runExampleApp(17))
  
})