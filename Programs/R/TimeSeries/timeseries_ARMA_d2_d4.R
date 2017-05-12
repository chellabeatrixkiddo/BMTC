library(timeSeries)
library(readxl)
library(utils)
library(tseries)

bunch_ts <- read_excel('segmented_bunching_data_20.xlsx', sheet = "d2_d4", col_names=TRUE)
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

#test for stationarity of second differences
adf.test(second_diff, alternative = "stationary")


#ar_ts<-arima(second_diff,order = c(0,2,0))
#print (ar_ts)
#plot(bunch_ts$time, second_diff, type = 'o', main = "Second Difference")






#Sir's code
'''
guessp<-2
guessq<-1
delta<-1
timeseries<-second_diff


library(forecast)
# guessp, guessq - Initial guesses for p and q (from ACF/PACF plots)
# delta - window in which we want to change guessp and guessq to
# look for alternative ARMA models
# timeseries - the one we want to analyze
tryArma <- function(delta, guessp, guessq, timeseries) {
df <- data.frame()
# generate all possible ARMA models
for (p in max(0,(guessp-delta)):(guessp+delta)) {
for (q in max(0,(guessq-delta)):(guessq+delta)) {
order <- c(p,0,q)
# Fit a maximum likelihood ARMA(p,q) model
armafit <- Arima(timeseries, order=order, method="ML")
# Add the results to the dataframe
df <- rbind(df, c(p, q, armafit$loglik, armafit$aic,
armafit$aicc, armafit$bic))
}
}
names(df) <- c("p","q","log.likelihood", "AIC", "AICc", "BIC")
return(df)
}
# Simulate a ARMA(2,2) series
#df <- tryArma(2,1,1,bunch_ts$X2)
'''

#Trying auto arima
auto_arima<-auto.arima(bunch_ts$X2,include.drift=TRUE)
print (auto_arima)


## Without Drift

#forecast.m <- plot(forecast(auto_arima,h=10))

#with Drift
armafit <- Arima(bunch_ts$X2, order=c(0,2,1), method="ML",include.drift=TRUE,include.mean = TRUE)
forecast.t <- plot(forecast(armafit,h=50,level=c(95,99),fan=TRUE),ylab="Difference of Distance",xlab="Time")
legend(0,-5000,c("X Axis 1 unit=1/6 minute"))
abline(0, 0, col ="red")
points(145,0,col="black",pch=19)

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