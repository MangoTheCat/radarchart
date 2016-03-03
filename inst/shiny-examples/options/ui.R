library(radarchart)

shinyUI(pageWithSidebar(
  headerPanel('Radarchart Shiny Example'),
  sidebarPanel(
    checkboxGroupInput('selectedPeople', 'Who to include', 
                       names(radarchart::skills)[-1], selected="Rich")
  ),
  mainPanel(
    chartJSRadarOutput("radar", width = "450", height = "300"), width = 7
  )
))
