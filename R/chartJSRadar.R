#' Make a ChartJS Radar Plot
#'
#' R bindings to the radar plot in the chartJS library.
#'
#' @import htmlwidgets
#' @import htmltools
#'
#' @export
chartJSRadar <- function(scores, labs, width = NULL, height = NULL,
                         responsive = TRUE, labelSize = 18, addDots = TRUE,
                         colMatrix = diag(3) * 255, polyAlpha = .2,
                         lineAlpha = .8) {
  
  opList <- list( responsive = responsive, pointLabelFontSize = labelSize,
                  pointDot = addDots)
  
  # forward options using x
  datasets <- lapply(names(scores), function(x) list(label=x))
  
  for (i in seq_along(datasets)) {
    
    fillCol <- paste0("rgba(", paste0(colMatrix[i,], collapse=","), ",", polyAlpha, ")")
    lineCol <- paste0("rgba(", paste0(colMatrix[i,], collapse=","), ",", lineAlpha, ")")
    
    datasets[[i]]$data <- scores[[i]]             # Data Points
    
    datasets[[i]]$fillColor  <- fillCol           # Polygon Fill
    datasets[[i]]$strokeColor  <- lineCol         # Line Colour
    datasets[[i]]$pointColor  <- lineCol          # Point colour
    
    datasets[[i]]$pointStrokeColor  <- "#fff"     # Point outline
    datasets[[i]]$pointHighlightFill  <- "#fff"   # Point Highlight fill
    datasets[[i]]$pointHighlightStroke <- lineCol # Point Highlight line
  }
  
  x = list(data = list(labels=labs, datasets=datasets), options = opList)
  
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
