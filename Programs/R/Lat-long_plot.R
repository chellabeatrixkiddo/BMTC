library(readxl)
bus1<-read_excel('bus.xlsx',col_names=TRUE)

busid<-c("150219795","150220187","150220249")

plot(bus1$`150219795_LONG`,bus1$`150219795_LAT`,col="red",
     xlab = "Longitude",ylab = "Lattitude",main = "Lattitude vs Longitude")

lines(bus1$`150220249_LONG`,bus1$`150220249_LAT`,col="green")
lines(bus1$`150813511_LONG`,bus1$`150813511_LAT`,col="blue")
lines(bus1$`150814233_LONG`,bus1$`150814233_LAT`,col="pink")
legend("topright", legend=c("150219795", "150220249","150813511","150814233"),
       col=c("red", "green","blue","pink"), lty=1:2, cex=0.8)
long=c(bus1$`150219795_LONG`,bus1$`150220249_LONG`,bus1$`150813511_LONG`,bus1$`150814233_LONG`)
lat=c(bus1$`150219795_LAT`,bus1$`150220249_LAT`,bus1$`150813511_LAT`,bus1$`150814233_LAT`)
model<-lm(long~lat)


plot(long,lat,col = "blue",main = "Regression",
     abline(lm(lat ~ long),col="red",lwd="5"),cex = 0.5,pch = 3,xlab = "Long",ylab = "Lat")
