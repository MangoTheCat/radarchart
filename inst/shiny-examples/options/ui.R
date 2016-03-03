library(radarchart)

shinyUI(pageWithSidebar(
  headerPanel('Radarchart Shiny Example'),
  sidebarPanel(
    checkboxGroupInput('selectedPeople', 'Who to include', 
                       names(radarchart::skills)[-1], selected="Rich"),
    
    numericInput("maxScale", "maxScale - 0 for NULL (default)", value = 10, min = 0,
                 max = NA, step = 1),
    
    numericInput("scaleStepWidth", "scaleStepWidth - 0 for NULL (default)", 
                 value = 0, min = 0, max = NA, step = 1),
    
    numericInput("scaleStartValue", "scaleStartValue - 0 is the default", 
                 value = 0, min = NA, max = NA, step = 1)
  ),
  mainPanel(
    chartJSRadarOutput("radar", width = "450", height = "300"), 
    code(textOutput("radarCall")), width = 7
  )
))
