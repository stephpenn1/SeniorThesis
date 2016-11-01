#Stephanie Pennington | Senior Thesis
#Historical(1970-1990) and RCP8.5 (2030-2050)
#CMIP5 CESM1-BGC Data
#Created 9-13-16 | Revised 10-4-16

# ---- SURFACE DIFFERENCE PLOTS ----

library(ncdf4)
library(fields)
ncid1 <- nc_open("rhopoto_hist_19701990.nc_regridfile.nc")
#ncid2 <- nc_open("rhopoto_hist_19701990.nc_regridfile.nc")

#print(ncid)
#temp_hist<-ncvar_get(ncid1, "thetao")
#salt_hist<-ncvar_get(ncid1, "so")
rho_hist<-ncvar_get(ncid1, "rhopoto")
lon <-ncvar_get(ncid1,"lon")
lat <-ncvar_get(ncid1,"lat")
time <-ncvar_get(ncid1,"time")
depth <- ncvar_get(ncid1, "lev")

#let's pull out the first level and the first date
#o2_depth<-oxy_hist[ , , ]
#salt_surf_hist<-salt_hist[ , ,1] 
#salt_u_hist<- salt_surf_hist*1000

#temp_surf_hist<-temp_hist[ , ,1]
#temp_u_hist<- temp_surf_hist-273.15 #changes units to Celsius

rho_surf_hist <- rho_hist[ , , 1]
rho_u_hist<- rho_surf_hist-1000

### RCP8.5

ncid3 <- nc_open("rhopoto_rcp85_20802100.nc_regridfile.nc")
#ncid4 <- nc_open("thetao_rcp85_20802100.nc_regridfile.nc")

#temp_rcp85<-ncvar_get(ncid3, "thetao")
#salt_rcp85<-ncvar_get(ncid3, "so")
rho_rcp85<-ncvar_get(ncid3, "rhopoto")

#let's pull out the first level and the first date
#o2_surf_rcp85<-oxy_rcp85[ , , ]  # the means we want all lat, one lon, all depths and 1-12 months
#salt_surf_rcp85<-salt_rcp85[ , ,1]
#salt_u_rcp85<- salt_surf_rcp85*1000

#temp_surf_rcp85<-temp_rcp85[ , ,1]
#temp_u_rcp85<- temp_surf_rcp85-273.15 

rho_surf_rcp85 <- rho_rcp85[ , , 1]
rho_u_rcp85<- rho_surf_rcp85-1000

## difference
diff_rho <- rho_u_rcp85 - rho_u_hist

#save plot
#png(file = "sp_surf_thetao_diff2.png", width = 650, height = 300, units = "mm",res = 100)
image.plot(lon,lat,diff_rho,
           xlab= "latitude", 
           ylab="longitude",
           ylim=rev(c(0 , -90)),
           xlim=c(150,300),
           zlim=c(-1,0.5))
           #sub = "")
title(main = "South Pacific Surface Density Difference\n 1970-1990 - 2080-2100") 
#dev.off()
#ylim=rev(c(-20,-90)),
#xlim=c(200,360))
par(new = T)
z = c(27.0,27.2)
contour(lon,lat,rho_u_hist, nlevels = 0, add = TRUE, zlim= range(z, finite = TRUE)) #hist contours
par(new = T)
contour(lon,lat,rho_u_rcp85, nlevels = 0, add = TRUE, lty = 4 , zlim= range(z, finite = TRUE)) #rcp85 contours, dashed
par(new = F)