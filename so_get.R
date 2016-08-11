#Stephanie Pennington | Senior Thesis
#Historical Salinity Data CMIP5
#Created 8.11.2016
# ------------------------
## OPEN SALINITY DATA ----
# ------------------------
library(ncdf4)
library(abind)
setwd("/Volumes/CMIP5_Data")
ncid <- nc_open("so_Omon_CESM1-BGC_historical_r1i1p1_197001-197912.nc") #opens first file
#print(ncid)
salt_1 <-ncvar_get(ncid, "so")
lon <-ncvar_get(ncid,"lon")
lat <-ncvar_get(ncid,"lat")
time <-ncvar_get(ncid,"time")
depth <- ncvar_get(ncid, "lev")

ncid <- nc_open("so_Omon_CESM1-BGC_historical_r1i1p1_198001-198912.nc") #opens first file
salt_2 <-ncvar_get(ncid, "so")

salt <- abind(salt_1, salt_2) #combines arrays
salt_surf<-salt[ , , 1, ] 
mean_salt<-apply(salt_surf, c(1,2), mean)
salt_u<- mean_salt*1000 #changes units to 3 sig figs
