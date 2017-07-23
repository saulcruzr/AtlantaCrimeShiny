library(data.table)
dataset <- read.csv("atlcrime.csv", header=TRUE, stringsAsFactors=FALSE)
dataset$incident_date<-as.Date(dataset$date,"%m/%d/%Y")
drops<-c("X","number","date","beat")
dataset<-dataset[,!(names(dataset) %in% drops)]
tableresults<-data.frame(x= numeric(0), y= integer(0), z = character(0))
colnames(tableresults)<-c("n2","n2","n3")