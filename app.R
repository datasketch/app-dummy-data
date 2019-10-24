library(shiny)
library(charlatan)

# Function to generate city names
ch_city <- function(n = 1, locale = NULL) {
  if (n == 1) {
    AddressProvider$new(locale = locale)$city()
  } else {
    x <- AddressProvider$new(locale = locale)
    replicate(n, x$city())
  }
}

# Function to generate emails
ch_email <- function(n = 1, locale = NULL) {
  if (n == 1) {
    InternetProvider$new(locale = locale)$email()
  } else {
    x <- InternetProvider$new(locale = locale)
    replicate(n, x$email())
  }
}

# Function to create table with variables outside generic ch_generate
genTable <- function(variables, rows) {
  cols <- stats::setNames(
    lapply(variables, function(var) {
      fun <- eval(parse(text = paste0("ch_", var)))
      fun(rows)
    }),
    variables
  )
  tibble::as_tibble(cols)
}

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

