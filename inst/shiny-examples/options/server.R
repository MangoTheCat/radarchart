library(radarchart)

shinyServer(function(input, output) {
  
  # Build the "call" statement
  # This is supposed to be the call made to chartJSRadar that would give the
  # current plot
  
  v <- reactiveValues( cmText = col2rgb(c("red", "forestgreen", "navyblue")))
  
  observeEvent(input$colButton, {
    if(!is.null(input$colMatValue)) {
      v$cmText <- eval(parse(text=input$colMatValue))
    } else {
      v$cmText <- NULL
    }
  })
  
  output$colMatText <- renderUI({
    cmValue <- reactive({
      if (input$colMat == "Named") {
        'col2rgb(c("red", "forestgreen", "navyblue"))'
      } else {
        "matrix(c(255, 0, 0, 34, 139, 34, 0, 0, 128), nrow = 3)"
      }
    })
    textInput("colMatValue", "Code: ", value=cmValue())
  })
  
  output$radarCall <- reactive({
    
    sk <- paste0("skills[, c(\"Label\"," ,
            paste0(paste0('"', input$selectedPeople, '"'), collapse=", "), ")]",
            collapse="")
    
    ms <- paste0("maxScale = ", ifelse(input$maxScale>0, input$maxScale, "NULL"))
    
    sw <- paste0("scaleStepWidth = ", 
                 ifelse(input$scaleStepWidth>0, input$scaleStepWidth, "NULL"))
    sv <- paste0("scaleStartValue = ", input$scaleStartValue)
    
    ls <- paste0("labelSize = ", input$labelSize)
    
    ad <- paste0("addDots = ", as.character(input$addDots))
    
    tt <- paste0("showToolTipLabel = ", as.character(input$showToolTipLabel))
    
    la <- paste0("lineAlpha = ", input$lineAlpha)
    
    pa <- paste0("polyAlpha = ", input$polyAlpha)
    
    rs <- paste0("responsive = ", as.character(input$responsive))
    
    cm <- paste0("colMatrix = ", input$colMatValue)

    arguments <- c(sk, ms, sw, sv, rs, ls, ad, la, pa, tt, cm)
    
    arguments[1] <- paste0("chartJSRadar(", arguments[1])
    arguments[length(arguments)] <- paste0(arguments[length(arguments)], ")")
    
    paste(arguments, sep="", collapse=", ")
    
  })
  
  
  # This is because the 0 represents NULL thing is hard to feed directly to the
  # chartJSRadar call
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

    # The main call
    chartJSRadar(skills[, c("Label", input$selectedPeople)], 
                 maxScale = maxScaleR(),
                 scaleStepWidth = scaleStepWidthR(),
                 scaleStartValue = input$scaleStartValue,
                 responsive = input$responsive,
                 labelSize = input$labelSize,
                 addDots = input$addDots,
                 lineAlpha = input$lineAlpha,
                 polyAlpha = input$polyAlpha,
                 showToolTipLabel=input$showToolTipLabel,
                 colMatrix = v$cmText)
  })
  
})