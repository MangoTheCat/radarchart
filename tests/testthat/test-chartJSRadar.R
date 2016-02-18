context("chartJSRadar")

test_that("chartJSRadar return object looks about right", {

  labs <- c("Communicator", "Data Wangler", "Programmer", "Technologist",  "Modeller", "Visualizer")
  scores <- list("Rich" = c(9, 7, 4, 5, 3, 7),
                 "Andy" = c(7, 6, 6, 2, 6, 9),
                 "Aimee" = c(6, 5, 8, 4, 7, 6),
                 "Doug" = c(4,5,8,9,8,2))

  a <- chartJSRadar(scores=scores, labs=labs, maxScale=10)
  
  # Check a few items for basic correctness
  expect_equal(names(a), c("x", "width", "height", "sizingPolicy", 
                           "dependencies", "elementId", "preRenderHook"))
  
  expect_equal(a$x$options,
               structure(list(responsive = TRUE, pointLabelFontSize = 18, 
                              pointDot = TRUE, scaleOverride = TRUE, scaleStepWidth = 1, 
                              scaleSteps = 10, scaleStartValue = 0), 
                         .Names = c("responsive", "pointLabelFontSize", 
                                    "pointDot", "scaleOverride", "scaleStepWidth", "scaleSteps", 
                                    "scaleStartValue")))
  
  expect_equal(a$x$data$datasets[[3]]$data, c(6, 5, 8, 4, 7, 6))
  
})
