context("Colours")

test_that("colourMatrix error checks", {
  
  # Needs a matrix input
  expect_error(colourMatrix(c("red", "green")))
  # A numeric matrix
  expect_error(colourMatrix(matrix(c("red", "green"))))
  
  
})

test_that("colourMatrix transformations", {
  
  testMat <- matrix(c(1000, 50, 20, 200, 988,400), nrow = 3)
  
  expect_warning(colourMatrix(testMat))
  
  # If it doesn't have 3 rows it's warns
  expect_warning(colourMatrix(t(testMat)))
  
  # This checks for rounding
  outMat <- suppressWarnings(colourMatrix(testMat))
  expectMat <- structure(c(255, 12, 5, 51, 251, 102), .Dim = c(3L, 2L))
  
  expect_equal(outMat, expectMat)
  
})