library(radarchart)

shinyUI(pageWithSidebar(
  headerPanel('Radarchart Options Chooser'),
  sidebarPanel(
    checkboxGroupInput('selectedPeople', 'Who to include', 
                       names(radarchart::skills)[-1], selected="Rich"),
    
    textInput("main", "main (title)", value = ""),
    
    numericInput("maxScale", "maxScale - 0 for NULL (default)", value = 10, min = 0,
                 max = NA, step = 1),
    
    numericInput("scaleStepWidth", "scaleStepWidth - 0 for NULL (default)", 
                 value = 0, min = 0, max = NA, step = 1),
    
    numericInput("scaleStartValue", "scaleStartValue - 0 is the default", 
                 value = 0, min = NA, max = NA, step = 1),
    
    numericInput("labelSize", "labelSize", value = 18, min = 1, max = NA, step = 1),
    
    numericInput("lineAlpha", "lineAlpha", value = 0.8, min = 0, max = 1, step = 0.05),
    
    numericInput("polyAlpha", "polyAlpha", value = 0.2, min = 0, max = 1, step = 0.05),
    
    checkboxInput("addDots", "addDots", value = TRUE),
    
    checkboxInput("showLegend", "showLegend", value = TRUE),
    
    checkboxInput("showToolTipLabel", "showToolTipLabel", value = FALSE),
    
    checkboxInput("responsive", "responsive", value = TRUE),
    
    radioButtons("colMat", "colMatrix", choices=c("Matrix", "Named"), 
                 selected = "Named", inline = TRUE),
    
    uiOutput("colMatText"),
    actionButton("colButton", "Update")
    
  ),
  mainPanel(
    p("Try changing the options in the side panel and then copy the function call that produces it."),
    chartJSRadarOutput("radar", width = "450", height = "300"), 
    code(textOutput("radarCall")), width = 7
  )
))
