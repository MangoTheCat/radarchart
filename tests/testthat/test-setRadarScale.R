context("Radar Scale")

test_that("setRadarscale returns correct structure", { 
  
  tStart <- 2
  tMax <- 15
  tStep <- 5
  
  scale <- setRadarScale(tMax, tStep, tStart)
  
  expect_identical(scale$ticks$min, tStart)
  expect_identical(scale$ticks$max, tMax)
  expect_identical(scale$ticks$stepSize, tStep)
})
