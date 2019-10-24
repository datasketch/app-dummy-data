library(shiny)
library(charlatan)

source('utils.R')

variables <- c(
  'Name' = 'name',
  'Job Title' = 'job',
  'Phone Number' = 'phone_number',
  'Email' = 'email',
  'City' = 'city'
)
  

ui <- fluidPage(
  titlePanel('fakeR: Generate fake data'),
  sidebarLayout(
    sidebarPanel(
      checkboxGroupInput(
        inputId = 'variables',
        label = 'Select the variables you want',
        choices = variables,
        selected = 'name'
      ),
      numericInput(
        inputId = 'rows',
        label = 'Number of rows',
        min = 1,
        value = 10
      )
    ),
    mainPanel(
      tableOutput('fakedata')
    )
  )
)

server <- function(input, output) {
  output$fakedata <- renderTable({
    genTable(input$variables, rows = input$rows)
  })
}

# Run the application 
shinyApp(ui = ui, server = server)

