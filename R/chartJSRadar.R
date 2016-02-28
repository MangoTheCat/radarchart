#' Make a ChartJS Radar Plot
#'
#' R bindings to the radar plot in the chartJS library
#'
#' @param scores Data frame or named list of scores for each axis. 
#' If \code{labs} is not specified then labels are taken from the first column (or element).
#' @param labs Labels for each axis. If left unspecified labels are taken from 
#' the scores data set. If set to NA then labels are left blank.
#' @param width Width of output plot
#' @param height Height of output plot
#' @param maxScale Max value on each axis
#' @param scaleStepWidth Spacing between rings on radar
#' @param scaleStartValue Value at the centre of the radar
#' @param responsive Logical. whether or not the chart should be responsive and resize when the browser does
#' @param labelSize Numeric. Point label font size in pixels
#' @param addDots Logical. Whether to show a dot for each point
#' @param colMatrix Numeric matrix of rgb colour values. If \code{NULL} defaults are used
#' @param polyAlpha Alpha value for the fill of polygons
#' @param lineAlpha Alpha value for the outlines
#' @param showToolTipLabel Logical. If \code{TRUE} then data set labels are shown in the tooltip hover over
#' @param ... Extra options passed straight to chart.js. Names must match existing options
#' \url{http://www.chartjs.org/docs/#getting-started-global-chart-configuration}
#'
#' @import htmlwidgets
#' @import htmltools
#'
#' @export
#' @examples 
#' # Using the data frame interface
#' chartJSRadar(scores=skills)
#' 
#' # Or using a list interface
#' labs <- c("Communicator", "Data Wangler", "Programmer", "Technologist",  "Modeller", "Visualizer")
#'
#' scores <- list("Rich" = c(9, 7, 4, 5, 3, 7),
#'  "Andy" = c(7, 6, 6, 2, 6, 9),
#'  "Aimee" = c(6, 5, 8, 4, 7, 6))
#'
#' # Default settings
#' chartJSRadar(scores=scores, labs=labs)
#' 
#' # Fix the max score
#' chartJSRadar(scores=scores, labs=labs, maxScale=10)
#' 
#' # Fix max and spacing
#' chartJSRadar(scores=scores, labs=labs, maxScale=12, scaleStepWidth = 2)
#' 
#' # Add pass through settings for extra options
#' chartJSRadar(scores=scores, labs=labs, maxScale =10, scaleLineWidth=5)
#' 
chartJSRadar <- function(scores, labs, width = NULL, height = NULL,
                         maxScale = NULL, scaleStepWidth = NULL,
                         scaleStartValue = 0, responsive = TRUE, labelSize = 18,
                         addDots = TRUE, colMatrix = NULL, polyAlpha = .2,
                         lineAlpha = .8, showToolTipLabel = FALSE, ...) {
  
  # Should we keep variable names consistent from chart.js to R?
  # Then we can just pass through anything that doesn't need preprocessing
  
  # If it comes through as a single vector wrap it back up
  if(!is.list(scores)) scores <- list(scores)

  # This block trys to handle different ways the data might
  # not look how we expect. Missings etc.
  if(missing(labs)) {
    if(is.character(scores[[1]]) | is.factor(scores[[1]])) {
      labs <- scores[[1]] # Copy the first column of scores into the labels
      if (length(scores) > 1) { # This catches empty data
        scores[[1]] <- NULL # Drop the labels column
      } else {
        # Add a dummy column with no data
        scores <- data.frame("null"=rep(NA, length(labs)))
      }
    } else {
      stop("if labs is unspecified then the first column of scores must be character data")
    }
  }

  
  
  # If NA is supplied then put blank labels  
  if(all(is.na(labs))) {
    labs <- rep("", length(scores[[1]]))
  }
    
  # Check data is in right shape
  x <- vapply(scores, function(x) length(x)==length(labs), FALSE)
  if(!all(x)) {
    stop("Each score vector must be the same length as the labs vector")
  }
  
  # Colours. Perhaps replace with proper palette
  if (is.null(colMatrix)) {
    colMatrix <- grDevices::col2rgb(c("red","green", "blue", "yellow", 
                              "magenta", "cyan", "orange", "purple", "pink"))
  }
  
  # Check for maxScale
  opScale <- setRadarScale(maxScale, scaleStepWidth, scaleStartValue)

  # Any extra options passed straight through. Names must match existing options
  # http://www.chartjs.org/docs/#getting-started-global-chart-configuration
  opPassThrough <- list(...)
  
  # Combine scale options, pass through and explicit options
  opList <- c(list( responsive = responsive, pointLabelFontSize = labelSize,
                  pointDot = addDots), opScale, opPassThrough)
  
  # Apply a switch as to whether the dataset names should show up on the hover over
  # If they set the global option themselves this will take priority
  if(!("multiTooltipTemplate" %in% names(opList))) {
    if(showToolTipLabel) {
      opList$multiTooltipTemplate <- "<%= value %> - <%= datasetLabel %>"
    }
  }
    
  # forward options using x
  datasets <- lapply(names(scores), function(x) list(label=x))
  
  for (i in seq_along(datasets)) {
    
    iCol <- (i-1) %% ncol(colMatrix) + 1 # cyclic repeat colours

    fillCol <- paste0("rgba(", paste0(colMatrix[ , iCol], collapse=","),
                      ",", polyAlpha, ")")
    lineCol <- paste0("rgba(", paste0(colMatrix[ , iCol], collapse=","), 
                      ",", lineAlpha, ")")
    
    datasets[[i]]$data <- scores[[i]]             # Data Points
    
    datasets[[i]]$fillColor  <- fillCol           # Polygon Fill
    datasets[[i]]$strokeColor  <- lineCol         # Line Colour
    datasets[[i]]$pointColor  <- lineCol          # Point colour
    
    datasets[[i]]$pointStrokeColor  <- "#fff"     # Point outline
    datasets[[i]]$pointHighlightFill  <- "#fff"   # Point Highlight fill
    datasets[[i]]$pointHighlightStroke <- lineCol # Point Highlight line
  }
  
  x <- list(data = list(labels=labs, datasets=datasets), options = opList)
  
  # create widget
  htmlwidgets::createWidget(
    name = "chartJSRadar",
    x,
    width = width,
    height = height,
    package = "radarchart"
  )
}

#' Autoscale the radar plot
#'
#' @param maxScale Numeric length 1. Desired max limit
#' @param scaleStepWidth Numeric length 1. Spacing between rings
#' @param scaleStartValue Numeric length 1. Value of the centre
#'
#' @return A list containing the scale options for chartjs
#'
#' @examples
#' \dontrun{
#' setRadarScale(15, 3)
#' setRadarScale(15, 5, 2)
#' }
setRadarScale <- function(maxScale = NULL, scaleStepWidth = NULL, 
                          scaleStartValue = 0) {
  
  if (!is.null(maxScale)) {
    
    opScale <- list(scaleOverride = TRUE)
    
    # Did they fix the tick points?
    if (!is.null(scaleStepWidth)) {
      opScale$scaleStepWidth <- scaleStepWidth
    } else {
      if (maxScale-scaleStartValue <= 12) {
        opScale$scaleStepWidth <- 1
      } else {
        opScale$scaleStepWidth <- floor( (maxScale-scaleStartValue) / 10)
      }
    }
    opScale$scaleSteps <- ceiling( (maxScale - scaleStartValue) / 
                                    opScale$scaleStepWidth)
    opScale$scaleStartValue <- scaleStartValue
  } else {
    opScale <- NULL
  }
  
  opScale
}

#' Tell htmltools where to output the chart
#' 
#' @param id The id of the target object
#' @param style css stylings
#' @param class class of the target
#' @param width width of target
#' @param height height of target
#' @param ... extra arguments currently unused
#' 
#' @export
chartJSRadar_html <- function(id, style, class, width, height, ...){
  htmltools::tags$canvas(id = id, class = class, width=width, height=height)
}

#' Widget output function for use in Shiny
#'
#' @param outputId output variable to read from
#' @param width Must be valid CSS unit
#' @param height Must be valid CSS unit
#'
#' @export
chartJSRadarOutput <- function(outputId, width = "450", height = "300"){
  shinyWidgetOutput(outputId, "chartJSRadar", width, height, package = "radarchart")
}

#' Widget render function for use in Shiny
#'
#' @param expr expression passed to \link[htmlwidgets]{shinyRenderWidget}
#' @param env environment in which to evaluate expression
#' @param quoted Logical. Is expression quoted?
#'
#' @export
renderChartJSRadar <- function(expr, env = parent.frame(), quoted = FALSE) {
  if (!quoted) { 
    expr <- substitute(expr) 
  } # force quoted
  shinyRenderWidget(expr, chartJSRadarOutput, env, quoted = TRUE)
}
