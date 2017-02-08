#Import Libraries
library(readxl)
library(plotly)

#Import Dataset from Excel
bus1<-read_excel('bus_red.xlsx',col_names=TRUE)

#Subset data frame one for each device id
device1 = na.omit(subset(bus1, select = c('150219795_LAT', '150219795_LONG', '150219795_TIME_SECS')))
device2 = na.omit(subset(bus1, select = c('150220249_LAT', '150220249_LONG', '150220249_TIME_SECS')))
device3 = na.omit(subset(bus1, select = c('150813511_LAT', '150813511_LONG', '150813511_TIME_SECS')))
device4 = na.omit(subset(bus1, select = c('150814233_LAT', '150814233_LONG', '150814233_TIME_SECS')))

#Plotting Lat, Long and Time(secs)
pl<-plot_ly(x=device1$`150219795_LONG`,y=device1$`150219795_LAT`,z=device1$`150219795_TIME_SECS`,type="scatter3d",mode="line",marker=list(size = 2,
                                                                                                                                 line = list(color = 'rgba(0, 255, 0, .8)',width = 1))) %>%
  add_trace(x=device1$`150219795_LONG`,y =device1$`150219795_LAT`,z=device1$`150219795_TIME_SECS`, name = '150219795',mode = 'lines') %>%
  add_trace(x=device2$`150220249_LONG`,y =device2$`150220249_LAT`,z=device2$`150220249_TIME_SECS`, name = '150220249',mode = 'lines') %>%
  add_trace(x=device3$`150813511_LONG`,y =device3$`150813511_LAT`,z=device3$`150813511_TIME_SECS`, name = '150813511',mode = 'lines') %>%
  add_trace(x=device4$`150814233_LONG`,y =device4$`150814233_LAT`,z=device4$`150814233_TIME_SECS`, name = '150814233',mode = 'lines') %>%
  
  add_markers() %>%
  layout(scene = list(xaxis = list(title = 'Longitude'),
                      yaxis = list(title = 'Latitude'),
                      zaxis = list(title = 'Time')))
print(pl)

#Plotting each bus' route 
plot(device1$`150219795_LONG`,device1$`150219795_LAT`,col="red",
     xlab = "Longitude",ylab = "Lattitude",main = "Lattitude vs Longitude")
lines(device2$`150220249_LONG`,device2$`150220249_LAT`,col="green")
lines(device3$`150813511_LONG`,device3$`150813511_LAT`,col="blue")
lines(device4$`150814233_LONG`,device4$`150814233_LAT`,col="pink")
legend("topright", legend=c("150219795", "150220249","150813511","150814233"),
       col=c("red", "green","blue","pink"), lty=1:2, cex=0.8)

#Plotting regression line
long=c(device1$`150219795_LONG`,device2$`150220249_LONG`,device3$`150813511_LONG`,device4$`150814233_LONG`)
lat=c(device1$`150219795_LAT`,device2$`150220249_LAT`,device3$`150813511_LAT`,device4$`150814233_LAT`)

model1<-lm(lat ~ long)
plot(long,lat,col = "blue",main = "Regression",
     abline(model1,col="red",lwd="5"),cex = 0.5,pch = 3,xlab = "Long",ylab = "Lat")


res1 <- signif(resid(model1), 5) #residuals
pre1 <- predict(model1) #predicted y values
segments(long, lat, long, pre1, col="green")

#Residual Graph:
#plot(long, res1, ylab = "Residuals", xlab = "Long", main = "Residuals", abline(0,0))

