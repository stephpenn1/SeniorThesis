# open and define variables

library(ncdf4)
ncid <- nc_open("/Users/SP/Desktop/JGCRI/rhopoto_Omon_CESM1-BGC_rcp85_r1i1p1_200601-200912.nc")
print(ncid)
rho<-ncvar_get(ncid, "rhopoto")
lon <-ncvar_get(ncid,"lon")
lat <-ncvar_get(ncid,"lat")
time <-ncvar_get(ncid,"time")
depth <- ncvar_get(ncid, "lev")
x<-mean_rho-1000

#let's pull out the first level and the first date
rho_surf<-rho[, , 1, 1:12]  # the means we want all lat, all lon, the 1st depth and 1-12 months 

# takes the mean of the 3th dimension time
mean_rho<-apply(rho_surf, c(1,2), mean) # this should return a 2-d matrix

#let's make lat and lon only 1 dimension
lat_1<-lat[1,]
lon_1<-lon[,1]
lon_sort<-sort(lon_1)

y<-lon_1-180

#quickly plot it
image(lon_sort,lat_1,x, 
      xlab= "Longitude", 
      ylab="Latitude", #axes labels
      main="Potential Density", #main plot title
      col = heat.colors(15, alpha =1)) #color palette

# or
contour(lon_sort,lat_1,x, 
        xlab= "Longitude", 
        ylab="Latitude", 
        main="Potential Density Contours")

# we see that the contours are 1030 ish which is a good density number. 


