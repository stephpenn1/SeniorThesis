#Stephanie Pennington | Senior Thesis
#Historical(1970-1990) and RCP8.5 (2030-2050)
#CMIP5 CESM1-BGC Data
#Created 9-13-16 | Revised 10-4-16

# ---- DEPTH DIFFERENCE PLOTS ----

library(ncdf4)
library(fields)
ncid1 <- nc_open("thetao_rcp85_20302050.nc_regridfile.nc")
ncid2 <- nc_open("so_rcp85_20302050.nc_regridfile.nc")

#print(ncid)
temp_hist<-ncvar_get(ncid1, "thetao")
salt_hist<-ncvar_get(ncid2, "so")
#rho_hist<-ncvar_get(ncid2, "rhopoto")
lon <-ncvar_get(ncid1,"lon")
lat <-ncvar_get(ncid1,"lat")
time <-ncvar_get(ncid1,"time")
depth <- ncvar_get(ncid1, "lev")

#let's pull out the first level and the first date
#o2_depth<-oxy_hist[ , , ]
salt_depth_hist<-salt_hist[240, , ] 
salt_u_hist<- salt_depth_hist*1000

temp_depth_hist<-temp_hist[240, , ]  
temp_u_hist<- temp_depth_hist-273.15 #changes units to 2 sig figs

#rho_depth_hist<-rho_hist[240, , ]
#rho_u_hist<- rho_depth_hist-1000

### RCP8.5

ncid3 <- nc_open("thetao_rcp85_20802100.nc_regridfile.nc")
ncid4 <- nc_open("so_rcp85_20802100.nc_regridfile.nc")

temp_rcp85<-ncvar_get(ncid3, "thetao")
salt_rcp85<-ncvar_get(ncid4, "so")
#rho_rcp85<-ncvar_get(ncid4, "rhopoto")
#time <-ncvar_get(ncid,"time")

#let's pull out the first level and the first date
#o2_depth_rcp85<-oxy_rcp85[ , , 888:1128]  # the means we want all lat, one lon, all depths and 1-12 months 
salt_depth_rcp85<-salt_rcp85[240, , ] 
salt_u_rcp85<- salt_depth_rcp85*1000

temp_depth_rcp85<-temp_rcp85[240, , ]
temp_u_rcp85<- temp_depth_rcp85-273.15 

#rho_depth_rcp85<-rho_rcp85[240, , ]
#rho_u_rcp85<- rho_depth_rcp85-1000

## difference
diff_temp <- temp_u_rcp85 - temp_u_hist

#png(file = "150W_depth_thetao_diff2.png", width = 650, height = 300, units = "mm",res = 100)
image.plot(lat,depth,diff_temp,
           xlab= "latitude", 
           ylab="depth [m]",
           xlim = c(-75,0), #only want equator to 75S
           ylim = c(2000,0)) #only want the top 2000 meters
           #zlim = c(0,1))
title(main = "120W Average Temperature Difference 2030-2050 - 2080-2100")          
#ylim=rev(c(-20 , -90)),
#xlim=c(200,360))
par(new = T)
contour(lat,depth,salt_u_hist, nlevels = 35, add = TRUE) #hist contours
par(new = T)
contour(lat,depth,salt_u_rcp85, nlevels = 35, add = TRUE, lty = 4) #rcp85 contours, dashed
par(new = F)