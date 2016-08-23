#Stephanie Pennington | Senior Thesis
#Historical(1970-1990) and RCP8.5 (2030-2050)
#Salinity/Potential Density Data - CMIP5 CESM1-BGC 
#Created 8.11.2016
# --------------------------------
#SURFACE PLOTS w CONTOURS
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

#pull out only the first level
salt_surf<-salt[ , , 1] #there are only three variables now instead of four since time was averaged out
#mean_salt<-apply(salt_surf, c(1,2), mean) #takes mean of time
salt_u<- salt_surf*1000 #changes units to 3 sig figs

rho_surf<-rho[ , ,1]  
#mean_rho<-apply(rho_surf, c(1,2), mean)
rho_u<- rho_surf-1000 #changes units to 2 sig figs

#let's make lat and lon only 1 dimension
lat_1<-lat[1,]
lon_1<-lon[,1]
lon_sort<-sort(lon_1) #sorts jumbled longitudes **needs to be fixed**

#plot the data; the first dataset is in color and the second is contoured on top
image.plot(lon_sort,lat_1,salt_u, 
           xlab= "Longitude", 
           ylab= "Latitude",
           sub = "Average Global Salinity 1970-1990",
           font.sub = 3, col.sub = "firebrick2") #axes labels
title(main = "Historical Salinity with Potential Density Overlay \n(psu) (kg/m^3)")
par(new = T)
contour(lon_sort,lat_1,rho_u, nlevels = 15, add = TRUE) #overlay contours
par(new = F)