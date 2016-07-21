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

# or
contour(lon_sort,lat_1,x, 
        xlab= "Longitude", 
        ylab="Latitude", 
        main="Potential Density Contours")

# we see that the contours are 1030 ish which is a good density number. 

#combine both plots into one
image(lon_sort,lat_1,x,
      xlab= "Longitude", 
      ylab="Latitude", #axes labels
      col = topo.colors(15)) #color palette
title(main = "Potential Density \nkg/m^3")
par(new = T)  #overlay plots
contour(lon_sort,lat_1,x, add= TRUE)
par(new = F)

