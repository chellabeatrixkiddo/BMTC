library(readxl)

#Import data from excel
bunch_data <- data.frame(read_excel('bunching_data_xl.xlsx', col_names = TRUE))

#Sort distance in descending order (do for each row)
sort_bunch_data <- t(apply(bunch_data[, -1:-2], 1, sort, decreasing = TRUE))
print(sort_bunch_data)

#replace zero distance with NA
sort_bunch_data[sort_bunch_data < 0.01] <- NA
print(sort_bunch_data)

diff_table <- data.frame(matrix(ncol = ncol(sort_bunch_data)-1, 
                                nrow = nrow(sort_bunch_data))) #required for nrows compatibility
for(i in 1: (ncol(sort_bunch_data)-1)){
  diff_table[ , i] <- sort_bunch_data[, i] - sort_bunch_data[ , i+1]
}
print(diff_table)

#omit NAs
diff_table[is.na(diff_table)] <- -5000
print(diff_table)

#plot time series
plot(bunch_data$time_seq, diff_table$X1, "l",col="red",
     xlab = "Time_secs",ylab = "Distance_difference",main = "Time Series")
lines(bunch_data$time_seq, diff_table$X2 ,col="green")
lines(bunch_data$time_seq, diff_table$X3 ,col="blue")
#lines(device4$`150814233_DISTANCE`,device4$`150814233_TIME_SECS`,col="pink")
#points(device2$`150220249_DISTANCE`[time_intersect_pos2], device2$`150220249_TIME_SECS`[time_intersect_pos2],col="red")
legend("topright", legend=c("d1 - d2","d2 - d3","d3 - d4"),
       col=c("red", "green","blue"), lty=1:2, cex=0.5)
