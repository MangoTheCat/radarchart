
#' <Add Title>
#'
#' <Add Description>
#'
#' @import htmlwidgets
#'
#' @export
hello2 <- function(message, width = NULL, height = NULL) {

  # forward options using x
  x = list(
    message = message
  )

  # create widget
  htmlwidgets::createWidget(
    name = 'hello2',
    x,
    width = width,
    height = height,
    package = 'radarchart'
  )
}

#' @export
hello2_html <- function(id, style, class, width, height, ...){
  htmltools::tags$canvas(id = id, class = class, width=width, height=height)
}


#' Widget output function for use in Shiny
#'
#' @export
hello2Output <- function(outputId, width = '100%', height = '400px'){
  shinyWidgetOutput(outputId, 'hello2', width, height, package = 'radarchart')
}

#' Widget render function for use in Shiny
#'
#' @export
renderHello2 <- function(expr, env = parent.frame(), quoted = FALSE) {
  if (!quoted) { expr <- substitute(expr) } # force quoted
  shinyRenderWidget(expr, hello2Output, env, quoted = TRUE)
}
