context("chartJSRadar")

test_that("chartJSRadar takes scores and labels", {

  labs <- c("Communicator", "Data Wangler", "Programmer", "Technologist",
            "Modeller", "Visualizer")
  scores <- list("Rich" = c(9, 7, 4, 5, 3, 7),
                 "Andy" = c(7, 6, 6, 2, 6, 9),
                 "Aimee" = c(6, 5, 8, 4, 7, 6),
                 "Doug" = c(4, 5, 8, 9, 8, 2))

  a <- chartJSRadar(scores = scores, labs = labs)
  
  # Expect that chart contains the correct scores for the first dataset
  expect_equal(a$x$data$datasets[[1]]$data, scores[[1]])
  
  # Expect that the chart contains the correct labels 
  expect_equal(a$x$data$labels, labs)
})

test_that("chartJSRadar takes a data frame", {
  
  scores <- data.frame("Label"= c("Communicator", "Data Wangler", "Programmer", 
                            "Technologist", "Modeller", "Visualizer"),
                 "Rich" = c(9, 7, 4, 5, 3, 7),
                 "Andy" = c(7, 6, 6, 2, 6, 9),
                 "Aimee" = c(6, 5, 8, 4, 7, 6),
                 "Doug" = c(4, 5, 8, 9, 8, 2))
  
  a <- chartJSRadar(scores = scores)
  
  expect_equal(a$x$data$labels, scores$Label)
  # Expect datasets length to equal number of cols in dataframe (minus the Label)
  expect_equal(length(a$x$data$datasets), ncol(scores) - 1)
})

test_that("chartJSRadar handles missing labels", {
  
  scores <- data.frame("Rich" = c(9, 7, 4, 5, 3, 7),
                       "Andy" = c(7, 6, 6, 2, 6, 9))
  
  # Missing labels and no character column in position 1
  expect_error(chartJSRadar(scores = scores))
  
  a <- chartJSRadar(scores = scores, labs = NA)
  
  # NA labels converted to blank
  expect_equal(a$x$data$labels, c("", "", "", "", "", ""))
  
  # If labels are specified they should be the right length
  expect_error(chartJSRadar(scores = scores, labs = LETTERS[1:3]))
})

test_that("chartJSRadar object has correct default options", {
  # Testing the exact structure seems a bit rigid
  
  labs <- c("Communicator", "Data Wangler", "Programmer", "Technologist",
            "Modeller", "Visualizer")
  scores <- list("Rich" = c(9, 7, 4, 5, 3, 7),
                 "Andy" = c(7, 6, 6, 2, 6, 9),
                 "Aimee" = c(6, 5, 8, 4, 7, 6),
                 "Doug" = c(4, 5, 8, 9, 8, 2))
  
  a <- chartJSRadar(scores = scores, labs = labs)
  
  # Define expected options
  exOptions <- list(responsive = TRUE, 
                    title = list(
                      display = FALSE, 
                      text = NULL),
                    scale = list(
                      ticks = list(min = 0),
                      pointLabels = list(fontSize = 18)),
                    tooltips = list(
                      enabled = TRUE,
                      mode = "label"),
                    legend = list(
                      display = TRUE)
  )
  expect_equal(a$x$options, exOptions)
})
