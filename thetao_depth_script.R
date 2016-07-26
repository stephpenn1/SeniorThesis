library(ncdf4)
library(fields)
ncid <- nc_open("/Users/SP/Desktop/JGCRI/thetao_Omon_SP-CCSM4_rcp85_r1i1p1_200601-200912.nc")
print(ncid)
temp <-ncvar_get(ncid, "thetao")
lon <-ncvar_get(ncid,"lon")
lat <-ncvar_get(ncid,"lat")
time <-ncvar_get(ncid,"time")
depth <- ncvar_get(ncid, "lev")

#let's pull out the first level and the first date
temp_depth<-temp[ ,258, , 1:12]  # the means we want all lat, one lon, all depths and 1-12 months 

# takes the mean of the 3th dimension time
mean_temp<-apply(temp_depth,c(1,2), mean) # this should return a 2-d matrix

#let's make lat and lon only 1 dimension
lat_1<-lat[1,]
lon_1<-lon[,1]
lon_sort<-sort(lon_1)

#y<-lon_1-180  #changes the scale to -180/+180

image.plot(lat_1,depth,mean_temp,
      xlab= "latitude", 
      ylab="depth [M]") #axes labels)
title(main = "Potential Temperature with Depth")
