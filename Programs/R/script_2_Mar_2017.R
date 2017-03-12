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

dev1_lat = c(device1$`150219795_LAT`)
dev1_long = c(device1$`150219795_LONG`)
dev2_lat = c(device2$`150220249_LAT`)
dev2_long = c(device2$`150220249_LONG`)
dev3_lat = c(device3$`150813511_LAT`)
dev3_long = c(device3$`150813511_LONG`)
dev4_lat = c(device4$`150814233_LAT`)
dev4_long = c(device4$`150814233_LONG`)

#Lat and Long positions where the trip starts each time-assumed to be Central Silk Board
trip_start_lat_long = c(12.916600, 77.623400)

#indexes of the points where the trip starts
trip_start_positions = array(0)
for(k in 1:4){
  if(k == 1){
    dev_lat = dev1_lat
    dev_long = dev1_long
  }
  else if(k == 2){
    dev_lat = dev2_lat
    dev_long = dev2_long
  }
  else if(k == 3){
    dev_lat = dev3_lat
    dev_long = dev3_long
  }
  else{
    dev_lat = dev4_lat
    dev_long = dev4_long
  }
   
  #indexes of the points where the trip starts
  start_positions = array(0)
  i = 1
  while(i <= length(dev_lat)){
    if((dev_lat[i] <= (trip_start_lat_long[1] + 0.000150) && dev_lat[i] >= (trip_start_lat_long[1])) && (dev_long[i] <= (trip_start_lat_long[2] + 0.000150) && dev_long[i] >= (trip_start_lat_long[2]))){
      start_positions = append(start_positions, i)
      
      while(i <= length(dev_lat) && (dev_lat[i] <= (trip_start_lat_long[1] + 0.000150) && dev_lat[i] >= (trip_start_lat_long[1])) && (dev_long[i] <= (trip_start_lat_long[2] + 0.000150) && dev_long[i] >= (trip_start_lat_long[2]))){
        i = i + 1
      }
    }
    i = i + 1
  }
  print(start_positions)
  trip_start_positions = append(trip_start_positions, start_positions)
}
trip_start_positions = trip_start_positions[3:length(trip_start_positions)]
print(trip_start_positions)

#calculate the distance of each lat-long point from the trip start position 
distanceval <- list()
timeval <- list()
chkflag = 0
index = 1 #to index into trip_start_positions array
for(k in 1:4){
  if(k == 1){
    dev_lat = dev1_lat
    dev_long = dev1_long
    dev_time_arr = device1$`150219795_TIME_SECS`
  }
  else if(k == 2){
    dev_lat = dev2_lat
    dev_long = dev2_long
    dev_time_arr = device2$`150220249_TIME_SECS`
  }
  else if(k == 3){
    dev_lat = dev3_lat
    dev_long = dev3_long
    dev_time_arr = device3$`150813511_TIME_SECS`
  }
  else{
    dev_lat = dev4_lat
    dev_long = dev4_long
    dev_time_arr = device4$`150814233_TIME_SECS`
  }
  dev_dist_l <- list()
  dev_time_l <- list()
  
  trip_no = 1 #to index into dev1_dist array
  flag = 0
  for(i in 1:length(dev_lat)){
    if(i == trip_start_positions[index] && chkflag == 0){ #trip starts
      index = index + 1
      
      if(index > length(trip_start_positions) || trip_start_positions[index] == 0){
        len = length(dev_lat) - trip_start_positions[index-1] + 1
        if(index > length(trip_start_positions))
          chkflag = 1
      }
      else
        len = trip_start_positions[index] - trip_start_positions[index-1] + 1
      
      dev_dist_l[[trip_no]] <- c(1:len-1)
      dev_time_l[[trip_no]] <- c(1:len-1)
      if(flag == 0){ #if it is the very first trip then just set the flag
        flag = 1
      }
      else{ #in case of subsequent trip update the list of distance vectors
        dev_dist_l[[trip_no]] = dev_distance[2:length(dev_distance)]
        dev_time_l[[trip_no]] = dev_time[2:length(dev_time)]
        trip_no = trip_no + 1
      }
      dist = 0
      dev_distance = array(dist)
      dev_time = array(0)
    }
    if(flag == 1){
      dist = (euc.dist(c(dev_lat[i+1], dev_long[i+1]), c(dev_lat[i], dev_long[i])) + dist)
      dev_distance = append(dev_distance, dist)
      dev_time = append(dev_time, dev_time_arr[i+1])
    }
  }
  #update for the last trip
  dev_dist_l[[trip_no]] = dev_distance[2:length(dev_distance)]
  dev_time_l[[trip_no]] = dev_time[2:length(dev_time)]
  if(index < length(trip_start_positions))
    index = index + 1
  
  #plots of distance vs time
  for(i in 1:length(dev_time_l)){
    devtrip = paste("Device Id ", k, "Trip-", i)
    plot(dev_time_l[[i]], dev_dist_l[[i]], col = "red", ylab = "Euclidean Distance", xlab = "Time", main = devtrip)
  }
  
  distanceval[[k]] = dev_dist_l
  timeval[[k]] = dev_time_l
}
