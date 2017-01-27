#Stephanie Pennington | Senior Thesis
#CDO command to loop over .nc files in directory,
#select years, take the mean, bilinear remap/regrid,
#write new file with _regrid.nc
 
for f in *.nc
do echo $f
cdo remapbil,r360x180 -timmean -selyear,1970/1990 $f ${f}_regrid.nc
done
