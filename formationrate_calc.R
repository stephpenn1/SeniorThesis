#Stephanie Pennington | Senior Thesis
#Formation Rate Calculation
#CMIP5 CESM1-BGC Data


library(ncdf4)
library(marelac)
library(fields)
library(colorspace)
setwd("/Users/SP/Desktop/cmip5_files/spring/spring")
ncid5 <- nc_open("areacello_fx_CESM1-BGC_rcp45_r0i0p0.nc_regrid.nc")
area <- ncvar_get(ncid5, "areacello")

## pull out values within the South Pacific
area_sp <- area[c(120,330), c(-30,-90)]
b_sp <- buoyancy_hist[c(120,330), c(-30,-90)]
rho_sp <- rho_hist[c(120,330),c(-30,-90), 1]
d_sigma <- 0.5

#FORMATION FOR 26.5 (denoted '_26')

## find index for density value
rho_index_26 <- which(rho_sp > 1026.45 & rho_sp < 1026.55)
b_index_26 <- b_sp[rho_index_26] ## find buoyancy at density index
b_sum_26 <- sum(b_index_26)

a_26 <- area_sp[rho_index_26] ## find area at density index
a_sum_26 <- sum(a_26)

f_26 <- (b_sum_26*a_sum_26)/(d_sigma*g) ## formation calculation

#FORMATION FOR 27

## find index for density value
rho_index_27 <- which(rho_sp > 1026.999 & rho_sp < 1027.03)
b_index_27 <- b_sp[rho_index_27] ## find buoyancy at density index
b_sum_27 <- sum(b_index_27)

a_27 <- area_sp[rho_index_27] ## find area at density index
a_sum_27 <- sum(a_27)

f_27 <- (b_sum_27*a_sum_27)/(d_sigma*g) ## formation calculation

f_total <- f_27 - f_26 ## subtract to get total formation within two density lines
