# open and define variables

install.packages(ncdf)
library(ncdf)
ncid <- nc_open("/Users/SP/Desktop/JGCRI/so_Omon_SP-CCSM4_rcp85_r1i1p1_200601-200912.nc")
print(ncid)
rho<-ncvar_get(ncid, "rhopoto")
lon <-ncvar_get(ncid,"lon")
lat <-ncvar_get(ncid,"lat")
time <-ncvar_get(ncid,"time")
depth <- ncvar_get(ncid, "lev")

#let's pull out the first level and the first date
rho_surf<-rho[, , 1 , 1]  # the means we want all lat, all lon, the 1st time and the 1st depth 

#let's make lat and lon only 1 dimension
lat_1<-lat[1,]
lon_1<-lon[,1]
lon_sort<-sort(lon_1)

#quickly plot it
image(lon_sort,lat_1,rho_surf)
# or
contour(lon_sort,lat_1,rho_surf) # we see that the contours are 1030 ish which is a good density number. 


