# libraries and source data
library(shiny)
data(mtcars)

# write a local file
source("read_local.R")

# Define UI for application that draws a histogram
ui <- fluidPage(

    # Application title
    titlePanel("Testing download data"),

    mainPanel(
      fluidRow(
        downloadButton("download", "Download a dataframe")
      ),
      br(),
      fluidRow(
        downloadButton("download_loc", "Downlod a local file")
      )
    )
)

# Define server logic required to draw a histogram
server <- function(input, output) {

  # download a dataframe
  output$download <- downloadHandler(
    filename = function(){"mydataframe.csv"}, 
    content = function(fname){
      z <- mtcars
      write.csv(z, fname)
    }
  )
  
  # download local file
  output$download_loc <- downloadHandler(
    filename <- function() {
      paste("output", "csv", sep=".")
    },
    
    content <- function(file) {
      file.copy("iris.csv", file)
    },
    contentType = "application/zip"
  )
  
    
}

# Run the application 
shinyApp(ui = ui, server = server)
