#Stephanie Pennington | Senior Thesis
#Historical(1970-1990) and RCP8.5 (2030-2050)
#CMIP5 CESM1-BGC Data
#Created 8-11-2016 | Revised 9-29-16

# --------------------------------
#SURFACE PLOTS w CONTOURS
# --------------------------------

setwd("/Users/SP/Desktop/cmip5_files") #set working directory to files

## --------------OPEN DATA ------------------
library(ncdf4)

# open the NetCDF files after it has gone through CDO
ncid <- nc_open("thetao_hist_19701990.nc_regridfile.nc")

#RCP8.5 2030-2050 outputs
#ncid <- nc_open("thetao_rcp85_20302050.nc_regridfile.nc")

#print(ncid)

#pull out variables
#salt <-ncvar_get(ncid, "so")
#rho <-ncvar_get(ncid, "rhopoto")
#oxy <-ncvar_get(ncid,"o2")
temp <-ncvar_get(ncid, "thetao")
lon <-ncvar_get(ncid,"lon")
lat <-ncvar_get(ncid,"lat")
time <-ncvar_get(ncid,"time")
#depth <- ncvar_get(ncid, "lev")

## --------------PLOT DATA------------------
library(fields)

#pull out only the first level

#oxy_surf<-oxy[ , 1]
#salt_surf<-salt[ , , 1]
#salt_u<- salt_surf*1000 #change units to 3 sig figs
#rho_surf <- rho[ , , 1]
#rho_u<- rho_surf-1000

#there are only three variables now instead of four since time was averaged out
temp_surf<-temp[ , , 1]
temp_u<- temp_surf-273.15 #change units to celsius

#plot the data; the first dataset is in color and the second is contoured on top
image.plot(lon,lat,temp_u, 
           xlab = "Longitude", 
           ylab = "Latitude",
           #ylim=rev(c(0 , -90)), #S.Pacific
           #xlim=c(150,300), #S.Pacific
           #zlim = c(33,34),
           sub = "Average Historic SST 1970-1990",
           font.sub = 3, col.sub = "firebrick2")
           #col = rainbow(150, start = .15, end = .75, alpha =1)) #axes labels
title(main = "Average Historic Surface Temperature in Southern Pacific\n (Celsius)") #kg/m^3
par(new = T)
contour(lon,lat,temp_u, nlevels = 10, add = TRUE) #overlay contours
par(new = F)