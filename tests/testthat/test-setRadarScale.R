context("Radar Scale")

test_that("Radar scale is running", { 
  
  expect_equal(setRadarScale(15, 5, 2),
               structure(list(scaleOverride = TRUE, scaleStepWidth = 5, 
                              scaleSteps = 3, scaleStartValue = 2), 
                         .Names = c("scaleOverride", "scaleStepWidth", 
                                    "scaleSteps", "scaleStartValue")))
  
  })
