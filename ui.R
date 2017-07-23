#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
library(leaflet)


# Define UI for application that plots a leaflet map and renders a data table 
shinyUI(fluidPage(
  
  # Application title
  titlePanel("Atlanta Crime 2009-2017"),
  
  # Sidebar with a slider input for number of bins 
  sidebarLayout(
    sidebarPanel(
      dateRangeInput("daterange1", "Date range:",
                     start = "2009-01-01",
                     end   = "2017-12-31"),
      checkboxGroupInput("crime", "Crime Type:",
                         unique(dataset$crime),
                         selected = "HOMICIDE"), #default value
      "The data is available in:",a("https://data.world/bryantahb/crime-in-atlanta-2009-2017")
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
      "This shiny app shows a collection of crime data from the Atlanta Police Department's open data portal. This example contains data for every month between January 2009 and February 2017.",
       "Use the filters on the left panel to filter the data in the map and table",
       fluidRow(leafletOutput(outputId = "mymap")),
       br(),br()
       ,dataTableOutput("results")
    )
  )
))

