#Stephanie Pennington | Senior Thesis
#Historical(1970-1990) and RCP8.5 (2030-2050)
#Salinity/Potential Density Data CMIP5 CESM1-BGC
#Created 8.9.2016
# --------------------------------
# ---- DEPTH PLOTS w CONTOURS ----
# --------------------------------

setwd("/Users/SP/Desktop/average-outputs") #set working directory to files

## --------------OPEN DATA ------------------
library(ncdf4)
# First we need to open the NetCDF files after it has gone through CDO
ncid <- nc_open("so_havg_output.nc")
ncid2 <- nc_open("rhopoto_havg_output.nc")

# RCP8.5 2030-2050 outputs
#ncid <- nc_open("so_r85avg3050_output.nc") 
#ncid2 <- nc_open("rhopoto_r85avg3050_output.nc")
#this file has already been merged and the time variable averaged
#print(ncid)

#pull out variables
salt <-ncvar_get(ncid, "so")
rho <-ncvar_get(ncid2, "rhopoto")
lon <-ncvar_get(ncid,"lon")
lat <-ncvar_get(ncid,"lat")
time <-ncvar_get(ncid,"time")
depth <- ncvar_get(ncid, "lev")

## --------------PLOT DATA------------------
library(fields)

#here we want all depths and only one specific longitude
salt_depth<-salt[222, , ]  #only three variables since time was averaged out
#mean_salt<-apply(salt_depth,c(1,2), mean) # this should return a 2-d matrix
salt_u<- salt_depth*1000 #changes units to 3 sig figs

rho_depth<-rho[222, , ]  
#mean_rho<-apply(rho_depth, c(1,2), mean) #takes mean of time
rho_u<- rho_depth-1000 #changes units to 2 sig figs

#let's make lat and lon only 1 dimension
lat_1<-lat[1,]
lon_1<-lon[,1]
lon_sort<-sort(lon_1) #sorts jumbled longitudes **needs to be fixed**

#plot the data; the first dataset is in color and the second is contoured on top
image.plot(lat_1,depth,salt_u,
      xlab= "latitude", 
      ylab="depth [M]",
      sub = "150W 1970-1990",
      font.sub = 3, col.sub = "turquoise4",
      xlim = c(-75,0), #only want equator to 75S
      ylim = c(2000,0), #only want the top 2000 meters
      zlim = c(33.5,35), #changes colorbar range
      col = rainbow(150, start = .1, end = .85, alpha =1)) #uses rainbow palette with 150 colors, hue ranges from .1 to .85
title(main = "Salinity with Potential Density Contours \n(psu) (kg/m^3)")
par(new = T)  #overlay plots
contour(lat_1,depth,rho_u, nlevels = 25, add= TRUE) #contour plot with 25 levels
par(new = F) #end overlay
