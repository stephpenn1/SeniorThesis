library(ncdf4)
library(fields)
library(abind)
ncid <- nc_open("so_Omon_CESM1-BGC_historical_r1i1p1_197001-197912.nc") #opens first file
print(ncid)
salt_1 <-ncvar_get(ncid, "so")
lon <-ncvar_get(ncid,"lon")
lat <-ncvar_get(ncid,"lat")
time <-ncvar_get(ncid,"time")
depth <- ncvar_get(ncid, "lev")

ncid <- nc_open("so_Omon_CESM1-BGC_historical_r1i1p1_198001-198912.nc") #opens first file
salt_2 <-ncvar_get(ncid, "so")

salt <- abind(salt_1, salt_2) #combines arrays
salt_depth<-salt[302, , , ]  #pulls out specific longitude #keeps all lat, time, depth 

# takes the mean of the time dimension
mean_salt<-apply(salt_depth,c(1,2), mean) # this should return a 2-d matrix
x<- mean_salt*1000 #changes units to 3 sig figs

#makes lat and lon only 1 dimension
lat_1<-lat[1,]
lon_1<-lon[,1]
lon_sort<-sort(lon_1)

#plots data
image.plot(lat_1,depth,x,
      xlab= "latitude", 
      ylab="depth [M]",
      sub = "150W 1970-1990",
      font.sub = 3, col.sub = "turquoise4",
      xlim = c(-75,0),
      ylim = c(3000,0),
      zlim = c(33.5,35), #changes colorbar range
      col = rainbow(150, start = .1, end = .85, alpha =1)) #uses rainbow palette with 150 colors, hue ranges from .1 to .85
title(main = "Salinity with Depth \n(psu)")
par(new = T)  #overlay plots
contour(lat_1,depth, x, nlevels = 40, add= TRUE) #contour plot with 40 levels
par(new = F) #end overlay
