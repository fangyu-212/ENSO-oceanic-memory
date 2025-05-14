#!/bin/bash

datadir=/ccc/store/cont003/gen1140/liufangy
JobName=eOR1L3P-IA-BLK-03-fy
ExperimentName=ORCA1ia
SpaceName=DEVT
TagName=ORCA1_LIM3_PISCES
dirout=${datadir}/IGCM_OUT/${TagName}/${SpaceName}/${ExperimentName}/${JobName}
export YearBegin=1980
export YearEnd=2018
(( YearFirst = ${YearBegin} - 1 ))
(( YearLast  = ${YearEnd}   + 1 ))

cd ${dirout}/FORCINGS_TEST_1980-2018

yr=${YearBegin}
while [ ${yr} -le ${YearEnd} ] ; do
  #clm
  ln -sf ${dirout}/FORCINGS/clm_1980-2018/${JobName}_clim1980-2018_3H_grid_U.nc              utau_${yr}.nc
  ln -sf ${dirout}/FORCINGS/clm_1980-2018/${JobName}_clim1980-2018_3H_grid_V.nc              vtau_${yr}.nc
  ln -sf ${dirout}/FORCINGS/clm_1980-2018/${JobName}_clim1980-2018_3H_SBC.nc                 hflux_${yr}.nc

  #ano
  ln -sf ${dirout}/FORCINGS/ano_1980-2018/HF/${JobName}_${yr}0101_${yr}1231_ano_3H_grid_U.nc utau_ano_${yr}.nc
  ln -sf ${dirout}/FORCINGS/ano_1980-2018/HF/${JobName}_${yr}0101_${yr}1231_ano_3H_grid_V.nc vtau_ano_${yr}.nc
  ln -sf ${dirout}/FORCINGS/clm_1980-2018/${JobName}_clim1980-2018_3H_SBC.nc                 hflux_ano_${yr}.nc
  
  #total
  ln -sf ${dirout}/OCE/Output/HF/${JobName}_${yr}0101_${yr}1231_3H_SBC.nc                    fflux_${yr}.nc
  ln -sf ${dirout}/ICE/Output/HF/${JobName}_${yr}0101_${yr}1231_3H_icemod.nc                 ice_${yr}.nc

  (( yr = ${yr} + 1 ))
done

ln -sf ${dirout}/FORCINGS/clm_1980-2018/${JobName}_clim1980-2018_3H_grid_U.nc                             utau_${YearFirst}.nc
ln -sf ${dirout}/FORCINGS/clm_1980-2018/${JobName}_clim1980-2018_3H_grid_V.nc                             vtau_${YearFirst}.nc
ln -sf ${dirout}/FORCINGS/clm_1980-2018/${JobName}_clim1980-2018_3H_SBC.nc                                hflux_${YearFirst}.nc
ln -sf ${dirout}/FORCINGS/ano_1980-2018/HF/${JobName}_${YearBegin}0101_${YearBegin}1231_ano_3H_grid_U.nc  utau_ano_${YearFirst}.nc
ln -sf ${dirout}/FORCINGS/ano_1980-2018/HF/${JobName}_${YearBegin}0101_${YearBegin}1231_ano_3H_grid_V.nc  vtau_ano_${YearFirst}.nc
ln -sf ${dirout}/FORCINGS/clm_1980-2018/${JobName}_clim1980-2018_3H_SBC.nc                                hflux_ano_${YearFirst}.nc
ln -sf ${dirout}/OCE/Output/HF/${JobName}_${YearBegin}0101_${YearBegin}1231_3H_SBC.nc                     fflux_${YearFirst}.nc
ln -sf ${dirout}/ICE/Output/HF/${JobName}_${YearBegin}0101_${YearBegin}1231_3H_icemod.nc                  ice_${YearFirst}.nc

ln -sf ${dirout}/FORCINGS/clm_1980-2018/${JobName}_clim1980-2018_3H_grid_U.nc                             utau_${YearLast}.nc
ln -sf ${dirout}/FORCINGS/clm_1980-2018/${JobName}_clim1980-2018_3H_grid_V.nc                             vtau_${YearLast}.nc
ln -sf ${dirout}/FORCINGS/clm_1980-2018/${JobName}_clim1980-2018_3H_SBC.nc                                hflux_${YearLast}.nc
ln -sf ${dirout}/FORCINGS/ano_1980-2018/HF/${JobName}_${YearEnd}0101_${YearEnd}1231_ano_3H_grid_U.nc      utau_ano_${YearLast}.nc
ln -sf ${dirout}/FORCINGS/ano_1980-2018/HF/${JobName}_${YearEnd}0101_${YearEnd}1231_ano_3H_grid_V.nc      vtau_ano_${YearLast}.nc
ln -sf ${dirout}/FORCINGS/clm_1980-2018/${JobName}_clim1980-2018_3H_SBC.nc                                hflux_ano_${YearLast}.nc
ln -sf ${dirout}/OCE/Output/HF/${JobName}_${YearEnd}0101_${YearEnd}1231_3H_SBC.nc                         fflux_${YearLast}.nc
ln -sf ${dirout}/ICE/Output/HF/${JobName}_${YearEnd}0101_${YearEnd}1231_3H_icemod.nc                      ice_${YearLast}.nc

