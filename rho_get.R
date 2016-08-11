#Stephanie Pennington | Senior Thesis
#Historical Salinity Data CMIP5
#Created 8.11.2016
# ------------------------
## OPEN POTENTIAL DENSITY DATA ----
# ------------------------
library(ncdf4)
library(abind)
ncid <- nc_open("rhopoto_Omon_CESM1-BGC_historical_r1i1p1_197001-197912.nc") #opens first file
print(ncid)
rho_1 <-ncvar_get(ncid, "rhopoto")
lon <-ncvar_get(ncid,"lon")
lat <-ncvar_get(ncid,"lat")
time <-ncvar_get(ncid,"time")
depth <- ncvar_get(ncid, "lev")

ncid <- nc_open("rhopoto_Omon_CESM1-BGC_historical_r1i1p1_198001-198912.nc") #opens first file
rho_2 <-ncvar_get(ncid, "rhopoto")

rho <- abind(rho_1, rho_2) #combines arrays
mean_rho<-apply(rho, c(1,2), mean) #takes mean of time