#' Make a ChartJS Radar Plot
#'
#' R bindings to the radar plot in the chartJS library.
#'
#' @import htmlwidgets
#' @import htmltools
#'
#' @export
chartJSRadar <- function(scores, labs, width = NULL, height = NULL) {

  # forward options using x
  datasets <- lapply(names(scores), function(x) list(label=x))
  
  for (i in seq_along(datasets)) {
    datasets[[i]]$data <- scores[[i]]
    datasets[[i]]$fillColor  <- "rgba(220,220,220,0.2)"
    datasets[[i]]$strokeColor  <- "rgba(220,220,220,1)"
    datasets[[i]]$pointColor  <- "rgba(220,220,220,1)"
    datasets[[i]]$pointStrokeColor  <- "#fff"
    datasets[[i]]$pointHighlightFill  <- "#fff"
    datasets[[i]]$pointHighlightStroke <- "rgba(220,220,220,1)"
  }
  
  x = list(labels=labs, datasets=datasets)

  # create widget
  htmlwidgets::createWidget(
    name = 'chartJSRadar',
    x,
    width = width,
    height = height,
    package = 'radarchart'
  )
}


#' @export
chartJSRadar_html <- function(id, style, class, width, height, ...){
  htmltools::tags$canvas(id = id, class = class, width=width, height=height)
}

#' Widget output function for use in Shiny
#'
#' @export
chartJSRadarOutput <- function(outputId, width = '100%', height = '400px'){
  shinyWidgetOutput(outputId, 'chartJSRadar', width, height, package = 'radarchart')
}

#' Widget render function for use in Shiny
#'
#' @export
renderChartJSRadar <- function(expr, env = parent.frame(), quoted = FALSE) {
  if (!quoted) { expr <- substitute(expr) } # force quoted
  shinyRenderWidget(expr, chartJSRadarOutput, env, quoted = TRUE)
}
