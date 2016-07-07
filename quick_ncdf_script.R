# open and define variables

install.packages(ncdf)
library(ncdf)
ncid <- open.ncdf("D:/CMIP5_HISTORICAL/rhopoto/rhopoto_Omon_GFDL-ESM2G_historical_r1i1p1_192101-192512.nc")
print(ncid)
rho<-get.var.ncdf(ncid, "rhopoto")
lon <-get.var.ncdf(ncid,"lon")
lat <-get.var.ncdf(ncid,"lat")
time <-get.var.ncdf(ncid,"time")
depth <- get.var.ncdf(ncid, "lev")

#let's pull out the first level and the first date
rho_surf<-rho[, , 1 , 1]  # the means we want all lat, all lon, the 1st time and the 1st depth 

#let's make lat and lon only 1 dimension
lat_1<-lat[1,]
lon_1<-lon[,1]

#quickly plot it
image(lon_1,lat_1,rho_surf)
# or
contour(lon_1,lat_1,rho_surf) # we see that the contours are 1030 ish which is a good density number. 

