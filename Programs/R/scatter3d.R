library(readxl)
bus1<-read_excel('bus_red.xlsx',col_names=TRUE)
library(plotly)



pl<-plot_ly(x=bus1$`150219795_LONG`,y=bus1$`150219795_LAT`,z=bus1$`150219795_TIME_SECS`,type="scatter3d",mode="line",marker=list(size = 2,
  line = list(color = 'rgba(0, 255, 0, .8)',width = 1))) %>%
  add_trace(x=bus1$`150219795_LONG`,y =bus1$`150219795_LAT`,z=bus1$`150219795_TIME_SECS`, name = '150219795',mode = 'lines') %>%
  #add_trace(x=bus1$`150220000_LONG`,y =bus1$`150220000_LAT`,z=bus1$`150220000_TIME_SECS`, name = '150220000',mode = 'lines') %>%
  #add_trace(x=bus1$`150220187_LONG`,y =bus1$`150220187_LAT`,z=bus1$`150220187_TIME_SECS`, name = '150220187',mode = 'lines') %>%
  add_trace(x=bus1$`150220249_LONG`,y =bus1$`150220249_LAT`,z=bus1$`150220249_TIME_SECS`, name = '150220249',mode = 'lines') %>%
  #add_trace(x=bus1$`150218641_LONG`,y =bus1$`150218641_LAT`,z=bus1$`150218641_TIME_SECS`, name = '150218641',mode = 'lines') %>%
  #add_trace(x=bus1$`150221135_LONG`,y =bus1$`150221135_LAT`,z=bus1$`150221135_TIME_SECS`, name = '150221135',mode = 'lines') %>%
  #add_trace(x=bus1$`150220937_LONG`,y =bus1$`150220937_LAT`,z=bus1$`150220937_TIME_SECS`, name = '150220937',mode = 'lines') %>%
  #add_trace(x=bus1$`150218093_LONG`,y =bus1$`150218093_LAT`,z=bus1$`150218093_TIME_SECS`, name = '150218093',mode = 'lines') %>%
  #add_trace(x=bus1$`150814324_LONG`,y =bus1$`150814324_LAT`,z=bus1$`150814324_TIME_SECS`, name = '150814324',mode = 'lines') %>%
  add_trace(x=bus1$`150813511_LONG`,y =bus1$`150813511_LAT`,z=bus1$`150813511_TIME_SECS`, name = '150813511',mode = 'lines') %>%
  add_trace(x=bus1$`150814233_LONG`,y =bus1$`150814233_LAT`,z=bus1$`150814233_TIME_SECS`, name = '150814233',mode = 'lines') %>%
  
  add_markers() %>%
  layout(scene = list(xaxis = list(title = 'Longitude'),
                     yaxis = list(title = 'Latitude'),
                      zaxis = list(title = 'Time')))
print(pl)

