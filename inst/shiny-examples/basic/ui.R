shinyUI(pageWithSidebar(
  headerPanel('Radarchart Shiny Example'),
  sidebarPanel(
    checkboxGroupInput('selectedPeople', 'Who to include', names(skills)[-1],
                       selected="Rich")
  ),
  mainPanel(
    chartJSRadarOutput("radar")
  )
))
