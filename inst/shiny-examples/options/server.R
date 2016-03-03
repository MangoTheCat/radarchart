library(radarchart)

shinyServer(function(input, output) {
  
  output$radarCall <- reactive({
    
    sk <- paste0("skills[, c(\"Label\"," ,
            paste0(paste0('"', input$selectedPeople, '"'), collapse=", "), ")]",
            collapse="")
    
    ms <- paste0("maxScale = ", ifelse(input$maxScale>0, input$maxScale, "NULL"))
    
    sw <- paste0("scaleStepWidth = ", 
                 ifelse(input$scaleStepWidth>0, input$scaleStepWidth, "NULL"))
    sv <- paste0("scaleStartValue = ", input$scaleStartValue)
    
    
    arguments <- c(sk, ms, sw, sv)
    
    arguments[1] <- paste0("chartJSRadar(", arguments[1])
    arguments[length(arguments)] <- paste0(arguments[length(arguments)], ")")
    
    paste(arguments, sep="", collapse=", ")
    
  })
  
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