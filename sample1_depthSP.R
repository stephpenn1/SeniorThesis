#Stephanie Pennington | Senior Thesis
#Historic(1970-1990) and RCP8.5(2030-2050)
#Salinity/Potential Density Data CMIP5 CESM1-BGC
#Created 8-9-16 | Revised 1-26-17

# ----- R code for depth plots w contours -----

#set directory
setwd("/Users/SP/Desktop/cmip5_files")

## --------------OPEN DATA ------------------

library(ncdf4)

#open the NetCDF files after averaged in CDO
#Historic 1970-1990 outputs
ncid <- nc_open("so_hist_19701990.nc_regridfile.nc")
ncid2 <- nc_open("rhopoto_hist_19701990.nc_regridfile.nc")

#RCP8.5 2030-2050 outputs
#ncid <- nc_open("rhopoto_rcp85_20302050.nc_regridfile.nc")
#ncid2 <- nc_open("salt_rcp85_20302050.nc_regridfile.nc")

#pull out variables
salt <-ncvar_get(ncid, "so")
rho <-ncvar_get(ncid2, "rhopoto")
lon <-ncvar_get(ncid,"lon")
lat <-ncvar_get(ncid,"lat")
time <-ncvar_get(ncid,"time")
depth <-ncvar_get(ncid, "lev")
#temp <-ncvar_get(ncid2, "thetao")

## --------------PLOT DATA------------------
library(fields)

#all depths and one longitude
salt_depth <-salt[240, , ]  #only three variables since time was averaged out
salt_u <-salt_depth*1000 #change units to 3 sig figs

rho_depth <-rho[240, , ]
rho_u <-rho_depth-1000 #change units to 2 sig figs

#temp_depth <-temp[240, , ]
#temp_u <-temp_depth-273.15

#plot data
#png(file = "180sorhohist.png", width = 650, height = 300, units = "mm",res = 500)
image.plot(lat,depth,salt_u,
           xlab= "latitude", 
           ylab="depth [M]",
           font.sub = 3, col.sub = "brown1",
           xlim = c(-75,0), #only want equator to 75S
           ylim = c(2000,0), #only want top 2000 meters
           zlim = c(33.5,35), #changes colorbar range
           col = rainbow(150, start = .15, end = .75, alpha =1)) #uses rainbow palette with 150 colors and hue ranges
title(main = "Average Historic Salinity - 120W") #(kg/m^3)
par(new = T)
contour(lat,depth,salt_u, nlevels = 30, drawlabels = TRUE, add= TRUE)
par(new = F) #end overlay
#dev.off()