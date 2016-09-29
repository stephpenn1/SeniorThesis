#Stephanie Pennington | Senior Thesis
#Historical(1970-1990) and RCP8.5 (2030-2050)
#Salinity/Potential Density Data CMIP5 CESM1-BGC
#Created 8-9-16 | Revised 9-29-16

# ---- DEPTH PLOTS w CONTOURS ----

#set working directory
setwd("/Users/SP/Desktop/cmip5_files")

## --------------OPEN DATA ------------------

library(ncdf4)

# First we need to open the NetCDF files after it has gone through CDO

ncid <- nc_open("rhopoto_hist_19701990.nc_regridfile.nc")
ncid2 <- nc_open("salt_hist_19701990.nc_regridfile.nc")

# RCP8.5 2030-2050 outputs
#ncid <- nc_open("rhopoto_rcp85_20302050.nc_regridfile.nc")
#ncid2 <- nc_open("salt_rcp85_20302050.nc_regridfile.nc")
#this file has already been merged and the time variable averaged

#print(ncid)

#pull out variables
salt <-ncvar_get(ncid2, "so")
rho <-ncvar_get(ncid, "rhopoto")
lon <-ncvar_get(ncid,"lon")
lat <-ncvar_get(ncid,"lat")
time <-ncvar_get(ncid,"time")
depth <- ncvar_get(ncid, "lev")

## --------------PLOT DATA------------------
library(fields)

#want all depths and one longitude
salt_depth<-salt[222, , ]  #only three variables since time was averaged out
salt_u<- salt_depth*1000 #change units to 3 sig figs

rho_depth<-rho[222, , ]
rho_u<- rho_depth-1000 #change units to 2 sig figs


#plot data
image.plot(lat,depth,salt_u,
           xlab= "latitude", 
           ylab="depth [M]",
           sub = "150W 1970-1990 (contour levels are in increments of 0.2 kg/m^3)",
           font.sub = 3, col.sub = "brown1",
           xlim = c(-75,0), #only want equator to 75S
           ylim = c(2000,0), #only want top 2000 meters
           zlim = c(33.5,35), #changes colorbar range
           col = rainbow(150, start = .15, end = .75, alpha =1)) #uses rainbow palette with 150 colors, hue ranges from .1 to .85
title(main = "Historic Salinity and Density in the Southern Pacific") #(kg/m^3)
par(new = T)
contour(lat_1,depth,rho_u, nlevels = 30, drawlabels = TRUE, add= TRUE)
par(new = F) #end overlay