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
        downloadButton("download_loc", "Download a local file")
      ),
      br(),
      fluidRow(
        downloadButton("download_zip", "Download a zip file")
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
  
  # download a zip
  output$download_zip <- downloadHandler(
    filename = function() {
      paste("output", "zip", sep=".")
    },
    content = function(fname) {
      fs <- c("mtcars.csv")
      tmpdir <- tempdir()
      setwd(tempdir())
      z <- mtcars
      write.csv(z, "mtcars.csv")
      
      zip(zipfile=fname, files=fs)
    },
    contentType = "application/zip"
  )
  
}

# Run the application 
shinyApp(ui = ui, server = server)
