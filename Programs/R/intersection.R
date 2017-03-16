#device id 1: 150219795
#device id 2: 150220249
#device id 3: 150813511
#device id 4: 150814233

#Import Libraries
library(readxl)

#Import Dataset from Excel
bus1<-read_excel('bus_red1.xlsx',col_names=TRUE)

#Subset data frame one for each device id
device1 = na.omit(subset(bus1, select = c('150219795_LAT', '150219795_LONG', '150219795_TIME_SECS','150219795_DISTANCE')))
device2 = na.omit(subset(bus1, select = c('150220249_LAT', '150220249_LONG', '150220249_TIME_SECS', '150220249_DISTANCE')))
device3 = na.omit(subset(bus1, select = c('150813511_LAT', '150813511_LONG', '150813511_TIME_SECS', '150813511_DISTANCE')))
device4 = na.omit(subset(bus1, select = c('150814233_LAT', '150814233_LONG', '150814233_TIME_SECS', '150814233_DISTANCE')))


#Intersection points in dist vs. time graph
dist_intersect <- intersect(round(device3$`150813511_DISTANCE`, 4), round(device2$`150220249_DISTANCE`,4))
dist_intersect_pos3 <- match(dist_intersect, round(device3$`150813511_DISTANCE`,4))
dist_intersect_pos2 <- match(dist_intersect, round(device2$`150220249_DISTANCE`,4))
print(dist_intersect)
print(dist_intersect_pos3)
print(dist_intersect_pos2)
print(device3$`150813511_TIME_SECS`[dist_intersect_pos3])
print(device2$`150220249_TIME_SECS`[dist_intersect_pos2])
time_intersect <- intersect(device3$`150813511_TIME_SECS`[dist_intersect_pos3], device2$`150220249_TIME_SECS`[dist_intersect_pos2])

print(time_intersect)
time_intersect_pos2 <- match(time_intersect, device2$`150220249_TIME_SECS`)
time_intersect_pos3 <- match(time_intersect, device3$`150813511_TIME_SECS`)
#get the (index of) points of intersection b/w 150220249 and 150813511
print(time_intersect_pos2)
print(time_intersect_pos3)


#plot_intersect <- intersect(dist_intersect, time_intersect)
#print(plot_intersect)

#Plotting dist vs. time
plot(device1$`150219795_DISTANCE`,device1$`150219795_TIME_SECS`, "l",col="red",
     xlab = "Distance",ylab = "Time_secs",main = "ROUTE DISTANCE vs TIME_SECS")
lines(device2$`150220249_DISTANCE`,device2$`150220249_TIME_SECS`,col="green")
lines(device3$`150813511_DISTANCE`,device3$`150813511_TIME_SECS`,col="blue")
lines(device4$`150814233_DISTANCE`,device4$`150814233_TIME_SECS`,col="pink")
points(device2$`150220249_DISTANCE`[time_intersect_pos2], device2$`150220249_TIME_SECS`[time_intersect_pos2],col="red")
legend("topright", legend=c("150219795", "150220249","150813511","150814233"),
       col=c("red", "green","blue","pink"), lty=1:2, cex=0.5)
