# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.

library(shiny)
library(ggplot2)
library(dplyr)
library(shinythemes)
library(datamods)
library(reactable)

load('./app.RData')

# Define UI for application that draws a histogram
ui <- fluidPage(
  theme = shinytheme("flatly"),
  titlePanel("National Health and Nutrition Examination Survey"),
  sidebarLayout(
    sidebarPanel(
      selectInput(
        inputId = 'groupvalue',
        label = 'Group values',
        choices = NameValue,
        selected = 'RIAGENDR'
      ),
      
      filter_data_ui("filtervalue", 
                     max_height = "800px")
    ),
    mainPanel(
      reactableOutput(outputId = "outcometable",
                      height = '400px'),
      plotOutput("outcomeplot")
    )
  )
)


server <- function(input, output, session) {
  
  Data1 <- reactive({
    Data
  })
  NameList <- reactive({
    as.list(NameValue)
  })
  datafilter <- filter_data_server(
    id = 'filtervalue',
    data = Data1,
    vars = NameList
  )
  
  output$outcomeplot <- renderPlot({
    groupvalue <- NameValue[1]
    groupvalue <- input$groupvalue
    
    Dataplot <- datafilter$filtered() |>
      rename(group = as.character(groupvalue))
    
    ggplot(data = Dataplot)+
      geom_jitter(mapping = aes(x = RIDAGEYR,
                                y = INDFMINC,
                                color = group))+
      theme_bw()+
      labs(x = 'Age',
           y = 'Family Income',
           color = names(groupvalue))
    
  })
  
  output$outcometable <- renderReactable({
    reactable(datafilter$filtered())
  })
}

# Run the application 
shinyApp(ui = ui, server = server)
