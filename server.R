#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

#install.packages("shiny)
library(shiny)
library(leaflet)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
  
  mymap<-leaflet(data=dataset)%>%
    addTiles()
  
  #This reactive dataset filters the data using the inputs coming from the UI
  dataset_filt<-reactive(dataset[dataset$crime%in%input$crime & dataset$incident_date>=input$daterange1[1] & dataset$incident_date<=input$daterange1[2],]
                         )
  
  #this reactive dataset aggregates the previously defined reactive dataset to show the frequency of incidents
  #by Neighborhood and Type of Crime
  summary_filt<-reactive(data.frame(table(Neighborhood=dataset_filt()$neighborhood,Crime=dataset_filt()$crime)))
  

  observe({
    if(nrow(dataset_filt())==0) {print(input$crime);leafletProxy("mymap",data=dataset_filt()) %>% clearMarkerClusters()}
    else{

    leafletProxy("mymap",data=dataset_filt())%>%clearMarkerClusters()%>%
        #default is Atlanta Downtown
        setView(lat=33.753746, lng=-84.386330,zoom=10)%>%
        addMarkers(lng=~long, lat = ~lat,clusterOptions = markerClusterOptions(), popup = paste("Crime:",dataset_filt()$crime, "<br>",
                                                                                              "Date:",dataset_filt()$incident_date, "<br>",
                                                                                              "Neighborhood:",dataset_filt()$neighborhood))%>%clearShapes()
  }
  })
  output$mymap <- renderLeaflet(mymap)
  output$results <- renderDataTable({
    summary_filt()
  }, options = list(pageLength=10))
    
  
})
  

