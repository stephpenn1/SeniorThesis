# open and define variables

library(ncdf4)
ncid <- nc_open("/Users/SP/Desktop/JGCRI/rhopoto_Omon_CESM1-BGC_rcp85_r1i1p1_200601-200912.nc")
print(ncid)
rho<-ncvar_get(ncid, "rhopoto")
lon <-ncvar_get(ncid,"lon")
lat <-ncvar_get(ncid,"lat")
time <-ncvar_get(ncid,"time")
depth <- ncvar_get(ncid, "lev")
x<-mean_rho-1000 #changes the density to 2 sig figs

#let's pull out the first level and the first date
rho_surf<-rho[, , 1, 1:12]  # the means we want all lat, all lon, the 1st depth and 1-12 months 

# takes the mean of the 3th dimension time
mean_rho<-apply(rho_surf, c(1,2), mean) # this should return a 2-d matrix

#let's make lat and lon only 1 dimension
lat_1<-lat[1,]
lon_1<-lon[,1]
lon_sort<-sort(y)

y<-lon_1-180  #changes the scale to -180/+180

#quickly plot it
image(lon_sort,lat_1,x, 
      xlab= "Longitude", 
      ylab="Latitude", #axes labels
      sub = "Plot of potential density in 2006, 1st depth",
      font.sub = 3, col.sub = "cornflowerblue",
      col = topo.colors(15, alpha =1))
title(main = "Potential Density \nkg/m^3")

#Salinity contour plot --------------------------------------------------

ncid <- nc_open("/Users/SP/Desktop/JGCRI/so_Omon_SP-CCSM4_rcp85_r1i1p1_200601-200912.nc")
print(ncid)
salt<-ncvar_get(ncid, "so")
lon <-ncvar_get(ncid,"lon")
lat <-ncvar_get(ncid,"lat")
time <-ncvar_get(ncid,"time")
depth <- ncvar_get(ncid, "lev")
#lat and lon 1 dimension
lat_1<-lat[1,]
lon_1<-lon[,1]
lon_sort<-sort(y)
y<-lon_1-180  #changes the scale to -180/+180

#let's pull out the first level and the first date
salt_surf<-salt[ , ,1, 1:12]  # the means we want all lat, all lon, depth 1-60, 1st month 

# takes the mean of the 3th dimension time
mean_salt<-apply(salt_surf, c(1,2), mean) # this should return a 2-d matrix

contour(lon_sort,lat_1,mean_salt,
        xlab= "Longitude", 
        ylab="Latitude", #axes labels
        sub = "Salinity contours for 2006, 1st depth",
        font.sub = 3, col.sub = "tomato") #produces contour plot
title(main = "Salinity Contours")

#Potential Density w Salinity overlay (2006-year average) --------------------------
image(lon_sort,lat_1,x, 
      xlab= "Longitude", 
      ylab="Latitude", #axes labels
      sub = "",
      font.sub = 3, col.sub = "cornflowerblue",
      col = topo.colors(15, alpha =1))
title(main = "Potential Density with Salinity Overlay")
par(new = T)
contour(lon_sort,lat_1,mean_salt, add = TRUE)
par(new = F)
