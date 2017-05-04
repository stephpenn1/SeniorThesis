#Stephanie Pennington | Senior Thesis
#Historical(1970-1990) and RCP8.5 (2030-2050)
#CMIP5 CESM1-BGC Data
#Created 9-13-16 | Revised 10-4-16

# ---- SURFACE DIFFERENCE PLOTS ----
setwd("/Users/SP/Desktop/cmip5_files/spring/spring/") #set working directory to files
library(ncdf4)
library(fields)
library(maps)
ncid1 <- nc_open("pr_day_CESM1-BGC_historical_r1i1p1_19550101-19891231.nc_regrid_hist.nc")
ncid2 <- nc_open("evspsbl_Amon_CESM1-BGC_historical_r1i1p1_185001-200512.nc_regrid_hist.nc")
ncid <- nc_open("so_hist_19701990.nc_regridfile.nc")
print(ncid1)
lon <-ncvar_get(ncid2,"lon")
lat <-ncvar_get(ncid2,"lat")
time <-ncvar_get(ncid2,"time")

#temp_hist<-ncvar_get(ncid1, "thetao")
salt_hist<-ncvar_get(ncid1, "so")
rho_hist<-ncvar_get(ncid, "rhopoto")
#hflux_hist <- ncvar_get(ncid1, "hfds")
wstress_hist <-ncvar_get(ncid1,"tauu")
#depth <- ncvar_get(ncid1, "lev")
precip_hist <-ncvar_get(ncid1,"pr")
evap_hist <-ncvar_get(ncid2, "evspsbl")

#o2_depth<-oxy_hist[ , , ]
salt_surf_hist<-salt_hist[ , ,1] 
salt_u_hist<- salt_surf_hist*1000
hflux_hist_depth <- hflux_hist[ , ]
#temp_surf_hist<-temp_hist[ , ,1]
#temp_u_hist<- temp_surf_hist-273.15 #changes units to Celsius

#mm/day precip_u_hist <- precip_hist*86400
evap_u_hist <- evap_hist*86400
rho_surf_hist <- rho_hist[ , , 1]
rho_u_hist<- rho_surf_hist-1000


### RCP8.5

ncid3 <- nc_open("pr_CESM1-BGC_rcp85_20060101-21001231.nc_regrid_eoc.nc")
ncid4 <- nc_open("evspsbl_Amon_CESM1-BGC_rcp85_r1i1p1_200601-210012.nc_regrid_eoc.nc")
ncid5 <- nc_open("so_rcp85_20802100.nc_regridfile.nc")

precip_rcp85 <-ncvar_get(ncid3,"pr")
evap_rcp85 <- ncvar_get(ncid4, "evspsbl")
hflux_rcp85 <- ncvar_get(ncid3, "hfds")
#temp_rcp85<-ncvar_get(ncid3, "thetao")
salt_rcp85<-ncvar_get(ncid3, "so")
rho_rcp85<-ncvar_get(ncid5, "rhopoto")
wstress_rcp85 <- ncvar_get(ncid3, "tauu")
precip_u_rcp85 <- precip_rcp85*86400
evap_u_rcp85 <- evap_rcp85*86400
hflux_rcp85_depth <- hflux_rcp85[ , ]
#let's pull out the first level and the first date
#o2_surf_rcp85<-oxy_rcp85[ , , ]  # the means we want all lat, one lon, all depths and 1-12 months
salt_surf_rcp85<-salt_rcp85[ , ,1]
salt_u_rcp85<- salt_surf_rcp85*1000

#temp_surf_rcp85<-temp_rcp85[ , ,1]
#temp_u_rcp85<- temp_surf_rcp85-273.15 

rho_surf_rcp85 <- rho_rcp85[ , , 1]
rho_u_rcp85<- rho_surf_rcp85-1000

## difference
salt_diff <- salt_u_rcp85 - salt_u_hist
diff_precip <- precip_u_rcp85 - precip_u_hist
diff_evap <- evap_u_rcp85 - evap_u_hist
pe <- diff_precip - diff_evap
diff_wstress <- wstress_rcp85 - wstress_hist
diff_hflux <- hflux_rcp85_depth- hflux_hist_depth
pe_hist <- precip_hist - evap_hist
pe_rcp85 <- precip_rcp85 - evap_rcp85
image.plot(lon,lat,salt_diff,
           xlab= "longitude", 
           ylab="latitude",
           ylim=rev(c(-30,-90)))
           #xlim=c(120,300),
           #zlim= c(-2,2),
           #col = cm.colors(10, alpha = 1))
           #col = rev(rainbow(150, start = .15, end = .75, alpha =1))) #axes labels
           #col = rev(heat.colors(10000, alpha = 1)))
title(main = "Zonal Wind Stress Difference (mm/day)\n 2080-2100 - 1970-1990") 
#ylim=rev(c(-20,-90)),
#xlim=c(200,360))
par(new = T)
z = c(26.6,27)
contour(lon,lat,rho_u_hist, nlevels = 0, add = TRUE, zlim= range(z, finite = TRUE), lwd=2) #hist contours
par(new = T)
contour(lon,lat,rho_u_rcp85, nlevels = 0, add = TRUE, zlim= range(z, finite = TRUE), lty=2, lwd=2) #hist contours
par(new = T)
map('world2', add = TRUE, ylim=rev(c(-30,-90)), xlim=c(120,300))
par(new = F)