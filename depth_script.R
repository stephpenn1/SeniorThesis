#Stephanie Pennington | Senior Thesis
#Historical Salinity Data CMIP5
#Created 8.9.2016

## DEPTH PLOTS -------------------------------------
library(fields)
salt_depth<-salt[222, , , ]  #pulls out specific longitude #keeps all lat, time, depth 
mean_salt<-apply(salt_depth,c(1,2), mean) # this should return a 2-d matrix
salt_u<- mean_salt*1000 #changes units to 3 sig figs

rho_depth<-rho[222, , , ]  
mean_rho<-apply(rho_depth, c(1,2), mean) #takes mean of time
rho_u<- mean_rho-1000 #changes units to 2 sig figs

#plots data
image.plot(lat_1,depth,salt_u,
      xlab= "latitude", 
      ylab="depth [M]",
      sub = "150W 1970-1990",
      font.sub = 3, col.sub = "turquoise4",
      xlim = c(-75,0),
      ylim = c(2000,0),
      zlim = c(33.5,35), #changes colorbar range
      col = rainbow(150, start = .1, end = .85, alpha =1)) #uses rainbow palette with 150 colors, hue ranges from .1 to .85
title(main = "Salinity with Potential Density Contours \n(psu) (kg/m^3)")
par(new = T)  #overlay plots
contour(lat_1,depth,rho_u, nlevels = 25, add= TRUE) #contour plot with 40 levels
par(new = F) #end overlay
