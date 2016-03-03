library(radarchart)

shinyServer(function(input, output) {
  output$radar <- renderChartJSRadar({
    
    chartJSRadar(skills[, c("Label", input$selectedPeople)], 
                 maxScale = 10, showToolTipLabel=TRUE)
  })
})