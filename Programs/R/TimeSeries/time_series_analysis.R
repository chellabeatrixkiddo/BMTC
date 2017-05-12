library(timeSeries)
library(readxl)
library(utils)

bunch_ts <- read_excel('segmented_bunching_data.xlsx', sheet = "d3_d4", col_names=TRUE)
plot(bunch_ts, type = 'o', main = "Before Detrending")

fit = lm(bunch_ts$X2~bunch_ts$time)
plot(bunch_ts$time, resid(fit), type = 'o', main = "Detrended using line fit")

first_diff <- c(0, diff(bunch_ts$X2))
plot(bunch_ts$time, first_diff, type = 'o', main = "First Difference")

second_diff <- c(0, diff(first_diff))
plot(bunch_ts$time, second_diff, type = 'o', main = "Second Difference")

acf(bunch_ts$X2, 48, main='acf: bunch_ts')
acf(resid(fit), 48, main='acf: detrended using line fit')
acf(first_diff, 48, main='acf: first differences')
acf(second_diff, main = 'acf: second differences')

pacf(bunch_ts$X2, 48, main='pacf: bunch_ts')
pacf(resid(fit), 48, main='pacf: detrended using line fit')
pacf(first_diff, 48, main='pacf: first differences')
pacf(second_diff, main = 'pacf: second differences')



##Results: quadratic trend in data hence second differences works

#######################################################################
# #load all sheets of segmented bunching data of differences
# bunch_ts_1 <- read_excel('segmented_bunching_data.xlsx', sheet = "d1_d4", col_names=TRUE)
# #change the col names appropriately
# names(bunch_ts_1) <- c("time1", "y1")
# bunch_ts_2 <- read_excel('segmented_bunching_data.xlsx', sheet = "d2_d4", col_names=TRUE)
# #change the col names appropriately
# names(bunch_ts_2) <- c("time2", "y2")
# bunch_ts_3 <- read_excel('segmented_bunching_data.xlsx', sheet = "d3_d4", col_names=TRUE)
# #change the col names appropriately
# names(bunch_ts_3) <- c("time3", "y3")
# 
# bunch_ts <- c(bunch_ts_1, bunch_ts_2, bunch_ts_3)
# print(bunch_ts)