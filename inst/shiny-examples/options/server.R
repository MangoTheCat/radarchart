library(radarchart)

shinyServer(function(input, output) {
  output$radar <- renderChartJSRadar({
    
    # Convert zero to a NULL
    maxScaleR <- reactive({
      if (input$maxScale>0)
        input$maxScale
      else
        NULL
    })
    # Convert zero to a NULL
    scaleStepWidthR <- reactive({
      if (input$scaleStepWidth>0)
        input$scaleStepWidth
      else
        NULL
    })
    
    chartJSRadar(skills[, c("Label", input$selectedPeople)], 
                 maxScale = maxScaleR(),
                 scaleStepWidth = scaleStepWidthR(),
                 scaleStartValue = input$scaleStartValue,
                 showToolTipLabel=TRUE)
  })
})