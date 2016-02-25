context("chartJSRadar")

test_that("chartJSRadar takes scores and labels", {

  labs <- c("Communicator", "Data Wangler", "Programmer", "Technologist",  "Modeller", "Visualizer")
  scores <- list("Rich" = c(9, 7, 4, 5, 3, 7),
                 "Andy" = c(7, 6, 6, 2, 6, 9),
                 "Aimee" = c(6, 5, 8, 4, 7, 6),
                 "Doug" = c(4,5,8,9,8,2))

  a <- chartJSRadar(scores=scores, labs=labs, maxScale=10)
  
  # Check data made it in
  expect_equal(a$x$options,
               structure(list(responsive = TRUE, pointLabelFontSize = 18, 
                              pointDot = TRUE, scaleOverride = TRUE, scaleStepWidth = 1, 
                              scaleSteps = 10, scaleStartValue = 0), 
                         .Names = c("responsive", "pointLabelFontSize", 
                                    "pointDot", "scaleOverride", "scaleStepWidth", "scaleSteps", 
                                    "scaleStartValue")))
  
  expect_equal(a$x$data$datasets[[3]]$data, c(6, 5, 8, 4, 7, 6))
  
})

test_that("chartJSRadar takes a data frame", {
  
  scores <- data.frame("Label"= c("Communicator", "Data Wangler", "Programmer", 
                            "Technologist",  "Modeller", "Visualizer"),
                 "Rich" = c(9, 7, 4, 5, 3, 7),
                 "Andy" = c(7, 6, 6, 2, 6, 9),
                 "Aimee" = c(6, 5, 8, 4, 7, 6),
                 "Doug" = c(4,5,8,9,8,2))
  
  a <-chartJSRadar(scores=scores, maxScale=10)
  
  expect_equal(a$x$data$labels, scores$Label)
  expect_equal(length(a$x$data$datasets), 4)
})

test_that("chartJSRadar handles missing labels", {
  
  scores <- data.frame("Rich" = c(9, 7, 4, 5, 3, 7),
                       "Andy" = c(7, 6, 6, 2, 6, 9))
  
  # Missing labels and no character column in position 1
  expect_error(chartJSRadar(scores=scores, maxScale=10))
  
  a <-chartJSRadar(scores=scores, labs = NA, maxScale = 10)
  
  # NA labels converted to blank
  expect_equal(a$x$data$labels, c("", "", "", "", "", ""))
  
  # If labels are specified they should be the right length
  expect_error(chartJSRadar(scores=scores, labs = LETTERS[1:3], maxScale=10))
  
})
