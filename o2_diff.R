library(ncdf4)
library(fields)
ncid <- nc_open("C:/Users/hart428/Downloads/o2_Omon_CESM1-BGC_historical_r1i1p1_185001-200512.nc")
print(ncid)
oxy_hist<-ncvar_get(ncid, "o2")
lon <-ncvar_get(ncid,"lon")
lat <-ncvar_get(ncid,"lat")
time <-ncvar_get(ncid,"time")
#depth <- ncvar_get(ncid, "depth")

#let's pull out the first level and the first date
o2_depth<-oxy_hist[ , , 1440:1681]  # the means we want all lat, one lon, all depths and 1-12 months 

# takes the mean of the 3th dimension time
mean_o2<-apply(o2_depth,c(1,2), mean) # this should return a 2-d matrix

#let's make lat and lon only 1 dimension
lat_1<-lat[1,]
lon_1<-lon[,1]
lon_sort<-sort(lon_1)

#y<-lon_1-180  #changes the scale to -180/+180

image.plot(lon_sort,lat_1,mean_o2,
      xlab= "latitude", 
      ylab="longitude") #axes labels)
title(main = "O2")

### RCP8.5

ncid <- nc_open("C:/Users/hart428/Downloads/o2_Omon_CESM1-BGC_rcp85_r1i1p1_200601-210012.nc")

oxy_rcp85<-ncvar_get(ncid, "o2")
time <-ncvar_get(ncid,"time")

#let's pull out the first level and the first date
o2_depth_rcp85<-oxy_rcp85[ , , 888:1128]  # the means we want all lat, one lon, all depths and 1-12 months 

# takes the mean of the 3th dimension time
mean_o2_rcp85<-apply(o2_depth_rcp85,c(1,2), mean) # this should return a 2-d matrix

#let's make lat and lon only 1 dimension
lat_1<-lat[1,]
lon_1<-lon[,1]
lon_sort<-sort(lon_1)

#y<-lon_1-180  #changes the scale to -180/+180

image.plot(lon_sort,lat_1,mean_o2_rcp85,
           xlab= "latitude", 
           ylab="longitude") #axes labels)
title(main = "O2")

## difference
diff_o2 <- mean_o2_rcp85 - mean_o2

image.plot(lon_sort,lat_1,diff_o2,
           xlab= "latitude", 
           ylab="longitude", 
          ylim=rev(c(-20 , -90)),
          xlim=c(200,360))
title(main = "O2 Difference 1970-1990 - 2080-2100")
par(new = T)
contour(lon_sort,lat_1,diff_o2, add = TRUE)
par(new = F)
