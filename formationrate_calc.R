#Stephanie Pennington | Senior Thesis
#Formation Rate Calculation
#CMIP5 CESM1-BGC Data


library(ncdf4)
library(marelac)
library(fields)
library(colorspace)
setwd("/Users/SP/Desktop/cmip5_files/spring/spring/")
ncid5 <- nc_open("areacello_fx_CESM1-BGC_rcp45_r0i0p0.nc_regrid.nc")
area <- ncvar_get(ncid5, "areacello")
area_sp <- area[c(120,330), c(-30,-90)]
d_sigma <- 0.5

#FORMATION FOR 26.5 (denoted '_26')

rho_index_26 <- which(rho_u_hist > 26.45 & rho_u_hist < 26.55)
b_index_26 <- buoyancy_hist[rho_index]
b_sum_26 <- sum(b_index)

a_26 <- area_sp[rho_index_26]
a_sum_26 <- sum(a_26)

f_26 <- (b_sum_26b*a_sum)/(d_sigma*g)

#FORMATION FOR 27

rho_index_27 <- which(rho_u_hist > 26.9 & rho_u_hist < 27.1)
b_index_27 <- buoyancy_hist[rho_index_27]
b_sum_27 <- sum(b_index_27)

a_27 <- area_sp[rho_index_27]
a_sum_27 <- sum(a_27)

f_27 <- (b_sum_27*a_sum_27)/(d_sigma*g)

f_total <- f_27 - f_26