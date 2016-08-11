#Stephanie Pennington | Senior Thesis
#Historical Salinity Data CMIP5
#Created 8.11.2016

## SURFACE PLOTS ---------------------------------------------
library(fields)
salt_surf<-mean_salt[ , , 1, ] #all lon, all lat, first depth, all time
mean_salt<-apply(salt_surf, c(1,2), mean) 
salt_u<- mean_salt*1000 #changes units to 3 sig figs

rho_surf<-rho[ , ,1, ]  
mean_rho<-apply(rho_surf, c(1,2), mean) #takes mean of time
rho_u<- mean_rho-1000 #changes units to 2 sig figs

#plot
image.plot(lon_sort,lat_1,salt_u, 
           xlab= "Longitude", 
           ylab= "Latitude",
           sub = "Average Global Salinity 1970-1990",
           font.sub = 3, col.sub = "firebrick2") #axes labels
title(main = "Historical Salinity \n(psu)")
par(new = T)
contour(lon_sort,lat_1,rho_u, nlevels = 15, add = TRUE) #overlay contours
par(new = F)