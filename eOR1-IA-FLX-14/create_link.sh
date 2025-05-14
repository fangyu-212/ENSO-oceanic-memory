#!/bin/bash

datadir=/ccc/store/cont003/gen1140/liufangy
JobName=eOR1L3P-IA-BLK-02-fy
ExperimentName=ORCA1ia
SpaceName=DEVT
TagName=ORCA1_LIM3_PISCES
dirout=${datadir}/IGCM_OUT/${TagName}/${SpaceName}/${ExperimentName}/${JobName}
export YearBegin=1958
export YearEnd=1967
(( YearFirst = ${YearBegin} - 1 ))
(( YearLast  = ${YearEnd}   + 1 ))

cd ${dirout}/FORCINGS


yr=${YearBegin}
while [ ${yr} -le ${YearEnd} ] ; do
  ln -sf ${dirout}/OCE/Output/HF/${JobName}_${yr}0101_${yr}1231_3H_grid_U.nc utau_${yr}.nc
  ln -sf ${dirout}/OCE/Output/HF/${JobName}_${yr}0101_${yr}1231_3H_grid_V.nc vtau_${yr}.nc
  ln -sf ${dirout}/OCE/Output/HF/${JobName}_${yr}0101_${yr}1231_3H_SBC.nc    flux_${yr}.nc
  ln -sf ${dirout}/ICE/Output/HF/${JobName}_${yr}0101_${yr}1231_3H_icemod.nc ice_${yr}.nc
  (( yr = ${yr} + 1 ))
done
  
ln -sf ${dirout}/OCE/Output/HF/${JobName}_${YearBegin}0101_${YearBegin}1231_3H_grid_U.nc utau_${YearFirst}.nc
ln -sf ${dirout}/OCE/Output/HF/${JobName}_${YearBegin}0101_${YearBegin}1231_3H_grid_V.nc vtau_${YearFirst}.nc
ln -sf ${dirout}/OCE/Output/HF/${JobName}_${YearBegin}0101_${YearBegin}1231_3H_SBC.nc    flux_${YearFirst}.nc
ln -sf ${dirout}/ICE/Output/HF/${JobName}_${YearBegin}0101_${YearBegin}1231_3H_icemod.nc ice_${YearFirst}.nc

ln -sf ${dirout}/OCE/Output/HF/${JobName}_${YearEnd}0101_${YearEnd}1231_3H_grid_U.nc utau_${YearLast}.nc
ln -sf ${dirout}/OCE/Output/HF/${JobName}_${YearEnd}0101_${YearEnd}1231_3H_grid_V.nc vtau_${YearLast}.nc
ln -sf ${dirout}/OCE/Output/HF/${JobName}_${YearEnd}0101_${YearEnd}1231_3H_SBC.nc    flux_${YearLast}.nc
ln -sf ${dirout}/ICE/Output/HF/${JobName}_${YearEnd}0101_${YearEnd}1231_3H_icemod.nc ice_${YearLast}.nc
