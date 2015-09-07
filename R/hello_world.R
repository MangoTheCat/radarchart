hello_world <- function(greeting="hello Shane") {
  
  x <- list(greeting=greeting)
  
  htmlwidgets::createWidget(x, width = 500, height=500)
  
}