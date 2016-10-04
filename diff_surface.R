#Stephanie Pennington | Senior Thesis
#Historical(1970-1990) and RCP8.5 (2030-2050)
#CMIP5 CESM1-BGC Data
#Created 9-13-16 | Revised 10-4-16

# ---- SURFACE DIFFERENCE PLOTS ----

library(ncdf4)
library(fields)
ncid1 <- nc_open("thetao_hist_19701990.nc_regridfile.nc")
ncid2 <- nc_open("so_hist_19701990.nc_regridfile.nc")

#print(ncid)
temp_hist<-ncvar_get(ncid1, "thetao")
salt_hist<-ncvar_get(ncid2, "so")
lon <-ncvar_get(ncid,"lon")
lat <-ncvar_get(ncid,"lat")
time <-ncvar_get(ncid3,"time")
depth <- ncvar_get(ncid, "lev")

#let's pull out the first level and the first date
#o2_depth<-oxy_hist[ , , ]
salt_surf_hist<-salt_hist[ , ,1] 
salt_u_hist<- salt_surf_hist*1000

temp_surf_hist<-temp_hist[ , ,1]
temp_u_hist<- temp_surf_hist-273.15 #changes units

### RCP8.5

ncid3 <- nc_open("thetao_rcp85_20802100.nc_regridfile.nc")
ncid4 <- nc_open("so_rcp85_20802100.nc_regridfile.nc")

temp_rcp85<-ncvar_get(ncid3, "thetao")
salt_rcp85<-ncvar_get(ncid4, "so")
time <-ncvar_get(ncid,"time")

#let's pull out the first level and the first date
#o2_surf_rcp85<-oxy_rcp85[ , , ]  # the means we want all lat, one lon, all depths and 1-12 months
salt_surf_rcp85<-salt_rcp85[ , ,1]
salt_u_rcp85<- salt_surf_rcp85*1000

temp_surf_rcp85<-temp_rcp85[ , ,1]
temp_u_rcp85<- temp_surf_rcp85-273.15 


## difference
diff_temp <- temp_u_rcp85 - temp_u_hist

#save plot
png(file = "sp_surf_thetao_diff2.png", width = 650, height = 300, units = "mm",res = 100)
image.plot(lon,lat,diff_temp,
           xlab= "latitude", 
           ylab="longitude",
           ylim=rev(c(0 , -90)),
           xlim=c(150,300),
           zlim=c(0,4))
           #sub = "")
title(main = "South Pacific Surface Temperature Difference\n 1970-1990 - 2080-2100") 
dev.off()
#ylim=rev(c(-20 , -90)),
#xlim=c(200,360))
par(new = T)
contour(lon,lat,salt_u_hist, nlevels = 35, add = TRUE)
par(new = F)