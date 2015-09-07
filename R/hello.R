#' <Add Title>
#'
#' <Add Description>
#'
#' @import htmlwidgets
#'
#' @export
hello <- function(message = "Hello world!", width = NULL, height = NULL) {
  
  # forward options using x
  x = list(
    message = message
  )
  
  # create widget
  htmlwidgets::createWidget(
    name = 'hello',
    x,
    width = width,
    height = height,
    package = 'radarchart'
  )
}