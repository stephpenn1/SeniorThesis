library(ncdf4)
library(fields)
library(abind)
ncid <- nc_open("so_Omon_CESM1-BGC_historical_r1i1p1_197001-197912.nc")
print(ncid)
salt_1 <-ncvar_get(ncid, "so")
lon <-ncvar_get(ncid,"lon")
lat <-ncvar_get(ncid,"lat")
time <-ncvar_get(ncid,"time")
depth <- ncvar_get(ncid, "lev")

ncid <- nc_open("so_Omon_CESM1-BGC_historical_r1i1p1_198001-198912.nc")
salt_2 <-ncvar_get(ncid, "so")
lon <-ncvar_get(ncid,"lon")
lat <-ncvar_get(ncid,"lat")
time <-ncvar_get(ncid,"time")
depth <- ncvar_get(ncid, "lev")

salt <- abind(salt_1, salt_2)

#let's pull out the first level and the first date
salt_depth<-salt[222, , , 1:240]  # the means we want all lat, one lon, all depths and 1-12 months 

# takes the mean of the 3th dimension time
mean_salt<-apply(salt_depth,c(1,2), mean) # this should return a 2-d matrix
x<- mean_salt*1000

#let's make lat and lon only 1 dimension
lat_1<-lat[1,]
lon_1<-lon[,1]
lon_sort<-sort(lon_1)

image.plot(lat_1,depth,x,
      xlab= "latitude", 
      ylab="depth [M]",
      sub = "150W 1970-1990",
      font.sub = 3, col.sub = "turquoise4",
      xlim = c(-75,0),
      ylim = c(3000,0),
      zlim = c(33.5,35), #changes colorbar range
      col = rainbow(150, start = .1, end = .85, alpha =1))
title(main = "Salinity with Depth \n(psu)")
par(new = T)  #overlay plots
contour(lat_1,depth, x, nlevels = 30, add= TRUE)
par(new = F)
