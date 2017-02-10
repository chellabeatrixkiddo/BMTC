#device id 1: 150219795
#device id 2: 150220249
#device id 3: 150813511
#device id 4: 150814233

#Import Libraries
library(readxl)
library(plotly)

#Function to calculate euclidean distance between 2 points
euc.dist <- function(x1, x2) sqrt(sum((x1 - x2) ^ 2))

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

#Plotting Regression Line
long=c(device1$`150219795_LONG`,device2$`150220249_LONG`,device3$`150813511_LONG`,device4$`150814233_LONG`)
lat=c(device1$`150219795_LAT`,device2$`150220249_LAT`,device3$`150813511_LAT`,device4$`150814233_LAT`)

model1<-lm(lat ~ long)
plot(long,lat,col = "blue",main = "Regression",
     abline(model1,col="red",lwd="5"),cex = 0.5,pch = 3,xlab = "Long",ylab = "Lat")


res1 <- signif(resid(model1), 5) #residuals
pre1 <- predict(model1) #predicted y-values - Lat values
segments(long, lat, long, pre1, col="green")

#Residual Graph:
#plot(long, res1, ylab = "Residuals", xlab = "Long", main = "Residuals", abline(0,0))

#starting point - Minimum Long-Lat point
start <- c(long[match(min(pre1), pre1)], min(pre1))

#ending point - Maximum Long-Lat point
end <- c(long[match(max(pre1), pre1)], max(pre1))

#create empty matrices to hold the projected Long-Lat points
dev1_proj <- matrix(, nrow = nrow(device1), ncol = 2)
dev2_proj <- matrix(, nrow = nrow(device2), ncol = 2)
dev3_proj <- matrix(, nrow = nrow(device3), ncol = 2)
dev4_proj <- matrix(, nrow = nrow(device4), ncol = 2)


#device id 1's projected Long-Lat points
dev1_proj[, 1] = long[1:nrow(device1)]
dev1_proj[, 2] = pre1[1:nrow(device1)] 
#device id 2's projected Long-Lat points
dev2_proj[, 1] = long[nrow(device1)+1:nrow(device2)] 
dev2_proj[, 2] = pre1[nrow(device1)+1:nrow(device2)] 
#device id 3's projected Long-Lat points
dev3_proj[, 1] = long[nrow(device2)+1:nrow(device3)]
dev3_proj[, 2] = pre1[nrow(device2)+1:nrow(device3)]
#device id 4's projected Long-Lat points
dev4_proj[, 1] = long[nrow(device3)+1:nrow(device4)]
dev4_proj[, 2] = pre1[nrow(device3)+1:nrow(device4)]

#empty arrays to hold the Euclidean Distance
dev1_dist <- c(1:nrow(device1))
dev2_dist <- c(1:nrow(device2))
dev3_dist <- c(1:nrow(device3))
dev4_dist <- c(1:nrow(device4))

#Euclidean Distance between (Current_long, Current_Lat) and (Start_Long, Start_Lat):
#for device id 1:
for(i in 1:nrow(dev1_proj)){
  dev1_dist[i] <- euc.dist(dev1_proj[i, ], start)
}
#for device id 2:
for(i in 1:nrow(dev2_proj)){
  dev2_dist[i] <- euc.dist(dev2_proj[i, ], start)
}
#for device id 3:
for(i in 1:nrow(dev3_proj)){
  dev3_dist[i] <- euc.dist(dev3_proj[i, ], start)
}
#for device id 4:
for(i in 1:nrow(dev4_proj)){
  dev4_dist[i] <- euc.dist(dev4_proj[i, ], start)
}

#plot the euclidean distances as a function
plot(1:length(dev1_dist), dev1_dist, col = "red", ylab = "Euclidean Distance", xlab = "Sequence", main = "Device Id 1")
plot(1:length(dev2_dist), dev2_dist, col = "red", ylab = "Euclidean Distance", xlab = "Sequence", main = "Device Id 2")
plot(1:length(dev3_dist), dev3_dist, col = "red", ylab = "Euclidean Distance", xlab = "Sequence", main = "Device Id 3")
plot(1:length(dev4_dist), dev4_dist, col = "red", ylab = "Euclidean Distance", xlab = "Sequence", main = "Device Id 4")
